require 'test_helper'

class Admins::ElectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admins_election = admins_elections(:one)
  end

  test "should get index" do
    get admins_elections_url
    assert_response :success
  end

  test "should get new" do
    get new_admins_election_url
    assert_response :success
  end

  test "should create admins_election" do
    assert_difference('Admins::Election.count') do
      post admins_elections_url, params: { admins_election: { position: @admins_election.position, year: @admins_election.year } }
    end

    assert_redirected_to admins_election_url(Admins::Election.last)
  end

  test "should show admins_election" do
    get admins_election_url(@admins_election)
    assert_response :success
  end

  test "should get edit" do
    get edit_admins_election_url(@admins_election)
    assert_response :success
  end

  test "should update admins_election" do
    patch admins_election_url(@admins_election), params: { admins_election: { position: @admins_election.position, year: @admins_election.year } }
    assert_redirected_to admins_election_url(@admins_election)
  end

  test "should destroy admins_election" do
    assert_difference('Admins::Election.count', -1) do
      delete admins_election_url(@admins_election)
    end

    assert_redirected_to admins_elections_url
  end
end
