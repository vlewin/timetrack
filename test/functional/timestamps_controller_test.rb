require 'test_helper'

class TimestampsControllerTest < ActionController::TestCase
  setup do
    @timestamp = timestamps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:timestamps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create timestamp" do
    assert_difference('Timestamp.count') do
      post :create, :timestamp => @timestamp.attributes
    end

    assert_redirected_to timestamp_path(assigns(:timestamp))
  end

  test "should show timestamp" do
    get :show, :id => @timestamp.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @timestamp.to_param
    assert_response :success
  end

  test "should update timestamp" do
    put :update, :id => @timestamp.to_param, :timestamp => @timestamp.attributes
    assert_redirected_to timestamp_path(assigns(:timestamp))
  end

  test "should destroy timestamp" do
    assert_difference('Timestamp.count', -1) do
      delete :destroy, :id => @timestamp.to_param
    end

    assert_redirected_to timestamps_path
  end
end
