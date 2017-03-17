require 'test_helper'

class Admins::PoliticiansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admins_politician = admins_politicians(:one)
  end

  test "should get index" do
    get admins_politicians_url
    assert_response :success
  end

  test "should get new" do
    get new_admins_politician_url
    assert_response :success
  end

  test "should create admins_politician" do
    assert_difference('Admins::Politician.count') do
      post admins_politicians_url, params: { admins_politician: { name: @admins_politician.name, party: @admins_politician.party, state_id: @admins_politician.state_id } }
    end

    assert_redirected_to admins_politician_url(Admins::Politician.last)
  end

  test "should show admins_politician" do
    get admins_politician_url(@admins_politician)
    assert_response :success
  end

  test "should get edit" do
    get edit_admins_politician_url(@admins_politician)
    assert_response :success
  end

  test "should update admins_politician" do
    patch admins_politician_url(@admins_politician), params: { admins_politician: { name: @admins_politician.name, party: @admins_politician.party, state_id: @admins_politician.state_id } }
    assert_redirected_to admins_politician_url(@admins_politician)
  end

  test "should destroy admins_politician" do
    assert_difference('Admins::Politician.count', -1) do
      delete admins_politician_url(@admins_politician)
    end

    assert_redirected_to admins_politicians_url
  end
end
