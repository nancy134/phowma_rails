require 'test_helper'

class Admins::AreaCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admins_area_code = admins_area_codes(:one)
  end

  test "should get index" do
    get admins_area_codes_url
    assert_response :success
  end

  test "should get new" do
    get new_admins_area_code_url
    assert_response :success
  end

  test "should create admins_area_code" do
    assert_difference('Admins::AreaCode.count') do
      post admins_area_codes_url, params: { admins_area_code: { code: @admins_area_code.code, state_id: @admins_area_code.state_id } }
    end

    assert_redirected_to admins_area_code_url(Admins::AreaCode.last)
  end

  test "should show admins_area_code" do
    get admins_area_code_url(@admins_area_code)
    assert_response :success
  end

  test "should get edit" do
    get edit_admins_area_code_url(@admins_area_code)
    assert_response :success
  end

  test "should update admins_area_code" do
    patch admins_area_code_url(@admins_area_code), params: { admins_area_code: { code: @admins_area_code.code, state_id: @admins_area_code.state_id } }
    assert_redirected_to admins_area_code_url(@admins_area_code)
  end

  test "should destroy admins_area_code" do
    assert_difference('Admins::AreaCode.count', -1) do
      delete admins_area_code_url(@admins_area_code)
    end

    assert_redirected_to admins_area_codes_url
  end
end
