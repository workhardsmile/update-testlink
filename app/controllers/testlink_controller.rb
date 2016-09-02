class TestlinkController < ApplicationController
  def update_status
    if params[:case_arrays]
      temp = OldTestCase.where(:case_id => params[:case_arrays]).select("test_link_id, automated_status")
      test_link_ids = temp.select{|i| i.automated_status != 'Update Needed' and i.automated_status != 'Not Ready for Automation'}.map{|i| i.test_link_id}
      UpdateStatusWorker.perform_async(test_link_ids)      
      render nothing: true
    else
      render text: "Failed to find case arrays in requests"
    end
  end

  def update_automation_test_name

    if params[:script_name] && params[:test_cases]
      test_link_ids = OldTestCase.where(:case_id => params[:test_cases]).select("test_link_id").map{|i| i.test_link_id}
      UpdateAutomationTestNameWorker.perform_async(params[:script_name], test_link_ids)
      render nothing: true
    else
      render text: "Failed to find script name and case arrays in requests"
    end

  end
end
