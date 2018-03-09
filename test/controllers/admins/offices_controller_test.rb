require 'test_helper'

class Admins::OfficesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admins_office = admins_offices(:one)
  end

  test "should get index" do
    get admins_offices_url
    assert_response :success
  end

  test "should get new" do
    get new_admins_office_url
    assert_response :success
  end

  test "should create admins_office" do
    assert_difference('Admins::Office.count') do
      post admins_offices_url, params: { admins_office: { district_id: @admins_office.district_id, politician_id: @admins_office.politician_id, position: @admins_office.position, state_id: @admins_office.state_id } }
    end

    assert_redirected_to admins_office_url(Admins::Office.last)
  end

  test "should show admins_office" do
    get admins_office_url(@admins_office)
    assert_response :success
  end

  test "should get edit" do
    get edit_admins_office_url(@admins_office)
    assert_response :success
  end

  test "should update admins_office" do
    patch admins_office_url(@admins_office), params: { admins_office: { district_id: @admins_office.district_id, politician_id: @admins_office.politician_id, position: @admins_office.position, state_id: @admins_office.state_id } }
    assert_redirected_to admins_office_url(@admins_office)
  end

  test "should destroy admins_office" do
    assert_difference('Admins::Office.count', -1) do
      delete admins_office_url(@admins_office)
    end

    assert_redirected_to admins_offices_url
  end
end
