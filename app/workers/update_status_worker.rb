class UpdateStatusWorker
  include Sidekiq::Worker

  def perform(test_link_ids)
    puts "(#{test_link_ids.join(',')})"
    field_id = 1
    if test_link_ids.count > 0
      # delete FROM testlink.cfield_design_values;  
      # select test_link_id from testlink.old_test_cases    
      # query_string ="update cfield_design_values v
        # set v.value = 'Automated'
        # where v.field_id = #{field_id}
        # and v.node_id in (
        # select n.id from nodes_hierarchy n
        # where n.parent_id in (#{test_link_ids.join(',')})
        # and n.node_type_id = 4)"
      delete_str ="delete from cfield_design_values v
        where v.field_id = #{field_id} and v.node_id in (
        select n.id from nodes_hierarchy n
        where n.parent_id in (#{test_link_ids.join(',')})
        and n.node_type_id = 4)"     
      insert_str = "insert into testlink.cfield_design_values(field_id,node_id,value) 
      select #{field_id},n.id,'Automated' from testlink.nodes_hierarchy n
      where n.node_type_id = 4 and n.parent_id in (#{test_link_ids.join(',')})"
      
      testlink = ActiveRecord::Base.establish_connection Rails.configuration.database_configuration['testlink']

      begin
        testlink.connection.execute(delete_str)
        testlink.connection.execute(insert_str)
      rescue Exception => e
        puts "--->> failed to update status for #{test_link_ids}, get error #{e}"
      ensure
        testlink.connection.close
      end


    end
  end

end
