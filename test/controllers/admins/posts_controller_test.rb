require 'test_helper'

class Admins::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admins_post = admins_posts(:one)
  end

  test "should get index" do
    get admins_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_admins_post_url
    assert_response :success
  end

  test "should create admins_post" do
    assert_difference('Admins::Post.count') do
      post admins_posts_url, params: { admins_post: { image: @admins_post.image, message: @admins_post.message } }
    end

    assert_redirected_to admins_post_url(Admins::Post.last)
  end

  test "should show admins_post" do
    get admins_post_url(@admins_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_admins_post_url(@admins_post)
    assert_response :success
  end

  test "should update admins_post" do
    patch admins_post_url(@admins_post), params: { admins_post: { image: @admins_post.image, message: @admins_post.message } }
    assert_redirected_to admins_post_url(@admins_post)
  end

  test "should destroy admins_post" do
    assert_difference('Admins::Post.count', -1) do
      delete admins_post_url(@admins_post)
    end

    assert_redirected_to admins_posts_url
  end
end
