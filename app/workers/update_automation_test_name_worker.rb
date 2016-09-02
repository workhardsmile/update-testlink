class UpdateAutomationTestNameWorker
  include Sidekiq::Worker

  def perform(script_name, testlink_ids)
    if testlink_ids.count > 0
      testlink = ActiveRecord::Base.establish_connection Rails.configuration.database_configuration['testlink']
      begin
        existing_sql = "SELECT n.parent_id as testlink_id FROM cfield_design_values v
        JOIN nodes_hierarchy n on n.id = v.node_id
        WHERE n.parent_id in (#{testlink_ids.join(',')}) AND v.field_id = 48 AND n.node_type_id = 4"

        update_testlink_ids = testlink.connection.execute(existing_sql).to_a.map{|i| i[0].to_s}
        insert_testlink_ids = testlink_ids - update_testlink_ids

        if insert_testlink_ids.count > 0
          insert_sql = "INSERT INTO cfield_design_values (field_id, value, node_id)
          SELECT 48, '#{script_name}', n.id FROM nodes_hierarchy n WHERE n.node_type_id = 4 AND n.parent_id in (#{insert_testlink_ids.join(',')})"
          testlink.connection.execute(insert_sql)
        end

        if update_testlink_ids.count > 0
          update_sql = "UPDATE cfield_design_values v SET v.value = '#{script_name}'
          WHERE v.field_id = 48 AND v.node_id in
          (SELECT n.id FROM nodes_hierarchy n WHERE n.node_type_id = 4 AND n.parent_id in (#{update_testlink_ids.join(',')}))"
          testlink.connection.execute(update_sql)
        end
      rescue Exception => e
        puts "--->> failed to update automation test name for #{testlink_ids}\n#{e}"
      ensure
        testlink.connection.close
      end
    end
  end
end
