require 'test_helper'

class Admins::ElectionResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admins_election_result = admins_election_results(:one)
  end

  test "should get index" do
    get admins_election_results_url
    assert_response :success
  end

  test "should get new" do
    get new_admins_election_result_url
    assert_response :success
  end

  test "should create admins_election_result" do
    assert_difference('Admins::ElectionResult.count') do
      post admins_election_results_url, params: { admins_election_result: { election_id: @admins_election_result.election_id, party: @admins_election_result.party, state_id: @admins_election_result.state_id } }
    end

    assert_redirected_to admins_election_result_url(Admins::ElectionResult.last)
  end

  test "should show admins_election_result" do
    get admins_election_result_url(@admins_election_result)
    assert_response :success
  end

  test "should get edit" do
    get edit_admins_election_result_url(@admins_election_result)
    assert_response :success
  end

  test "should update admins_election_result" do
    patch admins_election_result_url(@admins_election_result), params: { admins_election_result: { election_id: @admins_election_result.election_id, party: @admins_election_result.party, state_id: @admins_election_result.state_id } }
    assert_redirected_to admins_election_result_url(@admins_election_result)
  end

  test "should destroy admins_election_result" do
    assert_difference('Admins::ElectionResult.count', -1) do
      delete admins_election_result_url(@admins_election_result)
    end

    assert_redirected_to admins_election_results_url
  end
end
