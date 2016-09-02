class UpdateStatusWorker
  include Sidekiq::Worker

  def perform(test_link_ids)
    puts "(#{test_link_ids.join(',')})"
    if test_link_ids.count > 0
      query_string ="update cfield_design_values v
        set v.value = 'Automated'
        where v.field_id = 8
        and v.node_id in (
        select n.id from nodes_hierarchy n
        where n.parent_id in (#{test_link_ids.join(',')})
        and n.node_type_id = 4)"
      testlink = ActiveRecord::Base.establish_connection Rails.configuration.database_configuration['testlink']

      begin
        testlink.connection.execute(query_string)
      rescue Exception => e
        puts "--->> failed to update status for #{test_link_ids}, get error #{e}"
      ensure
        testlink.connection.close
      end


    end
  end

end
