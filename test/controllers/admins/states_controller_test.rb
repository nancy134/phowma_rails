require 'test_helper'

class Admins::StatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admins_state = admins_states(:one)
  end

  test "should get index" do
    get admins_states_url
    assert_response :success
  end

  test "should get new" do
    get new_admins_state_url
    assert_response :success
  end

  test "should create admins_state" do
    assert_difference('Admins::State.count') do
      post admins_states_url, params: { admins_state: { abbreviation: @admins_state.abbreviation, name: @admins_state.name } }
    end

    assert_redirected_to admins_state_url(Admins::State.last)
  end

  test "should show admins_state" do
    get admins_state_url(@admins_state)
    assert_response :success
  end

  test "should get edit" do
    get edit_admins_state_url(@admins_state)
    assert_response :success
  end

  test "should update admins_state" do
    patch admins_state_url(@admins_state), params: { admins_state: { abbreviation: @admins_state.abbreviation, name: @admins_state.name } }
    assert_redirected_to admins_state_url(@admins_state)
  end

  test "should destroy admins_state" do
    assert_difference('Admins::State.count', -1) do
      delete admins_state_url(@admins_state)
    end

    assert_redirected_to admins_states_url
  end
end
