require 'test_helper'

class LocsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get pending" do
    get :pending
    assert_response :success
  end

  test "should get edit_pub" do
    get :edit_pub
    assert_response :success
  end

  test "should get delete_pub" do
    get :delete_pub
    assert_response :success
  end

  test "should get confirm" do
    get :confirm
    assert_response :success
  end

  test "should get all" do
    get :all
    assert_response :success
  end

end
