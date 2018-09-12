require 'test_helper'

class Admins::MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admins_message = admins_messages(:one)
  end

  test "should get index" do
    get admins_messages_url
    assert_response :success
  end

  test "should get new" do
    get new_admins_message_url
    assert_response :success
  end

  test "should create admins_message" do
    assert_difference('Admins::Message.count') do
      post admins_messages_url, params: { admins_message: {  } }
    end

    assert_redirected_to admins_message_url(Admins::Message.last)
  end

  test "should show admins_message" do
    get admins_message_url(@admins_message)
    assert_response :success
  end

  test "should get edit" do
    get edit_admins_message_url(@admins_message)
    assert_response :success
  end

  test "should update admins_message" do
    patch admins_message_url(@admins_message), params: { admins_message: {  } }
    assert_redirected_to admins_message_url(@admins_message)
  end

  test "should destroy admins_message" do
    assert_difference('Admins::Message.count', -1) do
      delete admins_message_url(@admins_message)
    end

    assert_redirected_to admins_messages_url
  end
end
