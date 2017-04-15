require 'test_helper'

class Admins::ZipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admins_zip = admins_zips(:one)
  end

  test "should get index" do
    get admins_zips_url
    assert_response :success
  end

  test "should get new" do
    get new_admins_zip_url
    assert_response :success
  end

  test "should create admins_zip" do
    assert_difference('Admins::Zip.count') do
      post admins_zips_url, params: { admins_zip: { code: @admins_zip.code } }
    end

    assert_redirected_to admins_zip_url(Admins::Zip.last)
  end

  test "should show admins_zip" do
    get admins_zip_url(@admins_zip)
    assert_response :success
  end

  test "should get edit" do
    get edit_admins_zip_url(@admins_zip)
    assert_response :success
  end

  test "should update admins_zip" do
    patch admins_zip_url(@admins_zip), params: { admins_zip: { code: @admins_zip.code } }
    assert_redirected_to admins_zip_url(@admins_zip)
  end

  test "should destroy admins_zip" do
    assert_difference('Admins::Zip.count', -1) do
      delete admins_zip_url(@admins_zip)
    end

    assert_redirected_to admins_zips_url
  end
end
