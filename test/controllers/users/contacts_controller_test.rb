require 'test_helper'

class Users::ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @users_contact = users_contacts(:one)
  end

  test "should get index" do
    get users_contacts_url
    assert_response :success
  end

  test "should get new" do
    get new_users_contact_url
    assert_response :success
  end

  test "should create users_contact" do
    assert_difference('Users::Contact.count') do
      post users_contacts_url, params: { users_contact: { phone_id: @users_contact.phone_id } }
    end

    assert_redirected_to users_contact_url(Users::Contact.last)
  end

  test "should show users_contact" do
    get users_contact_url(@users_contact)
    assert_response :success
  end

  test "should get edit" do
    get edit_users_contact_url(@users_contact)
    assert_response :success
  end

  test "should update users_contact" do
    patch users_contact_url(@users_contact), params: { users_contact: { phone_id: @users_contact.phone_id } }
    assert_redirected_to users_contact_url(@users_contact)
  end

  test "should destroy users_contact" do
    assert_difference('Users::Contact.count', -1) do
      delete users_contact_url(@users_contact)
    end

    assert_redirected_to users_contacts_url
  end
end
