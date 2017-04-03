require 'test_helper'

class Admins::DistrictsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admins_district = admins_districts(:one)
  end

  test "should get index" do
    get admins_districts_url
    assert_response :success
  end

  test "should get new" do
    get new_admins_district_url
    assert_response :success
  end

  test "should create admins_district" do
    assert_difference('Admins::District.count') do
      post admins_districts_url, params: { admins_district: { name: @admins_district.name, state_id: @admins_district.state_id } }
    end

    assert_redirected_to admins_district_url(Admins::District.last)
  end

  test "should show admins_district" do
    get admins_district_url(@admins_district)
    assert_response :success
  end

  test "should get edit" do
    get edit_admins_district_url(@admins_district)
    assert_response :success
  end

  test "should update admins_district" do
    patch admins_district_url(@admins_district), params: { admins_district: { name: @admins_district.name, state_id: @admins_district.state_id } }
    assert_redirected_to admins_district_url(@admins_district)
  end

  test "should destroy admins_district" do
    assert_difference('Admins::District.count', -1) do
      delete admins_district_url(@admins_district)
    end

    assert_redirected_to admins_districts_url
  end
end
