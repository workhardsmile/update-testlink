require 'test_helper'

class OldTestCasesControllerTest < ActionController::TestCase
  setup do
    @old_test_case = old_test_cases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:old_test_cases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create old_test_case" do
    assert_difference('OldTestCase.count') do
      post :create, old_test_case: @old_test_case.attributes
    end

    assert_redirected_to old_test_case_path(assigns(:old_test_case))
  end

  test "should show old_test_case" do
    get :show, id: @old_test_case.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @old_test_case.to_param
    assert_response :success
  end

  test "should update old_test_case" do
    put :update, id: @old_test_case.to_param, old_test_case: @old_test_case.attributes
    assert_redirected_to old_test_case_path(assigns(:old_test_case))
  end

  test "should destroy old_test_case" do
    assert_difference('OldTestCase.count', -1) do
      delete :destroy, id: @old_test_case.to_param
    end

    assert_redirected_to old_test_cases_path
  end
end
