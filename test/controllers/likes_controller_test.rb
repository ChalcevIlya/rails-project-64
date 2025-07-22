# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:two)
    sign_in @user
  end

  test 'should like' do
    assert_difference('PostLike.count', 1) do
      post post_likes_path(@post)
    end
    assert_redirected_to post_path(@post.id)
  end

  test 'should not like twice' do
    post post_likes_path(@post)
    assert_no_difference('PostLike.count') do
      post post_likes_path(@post)
    end
    assert_redirected_to post_path(@post.id)
  end

  test 'should unlike a post' do
    like = post_likes(:one)
    assert_difference('PostLike.count', -1) do
      delete post_like_path(like.post, like)
    end
    assert_redirected_to post_path(like.post)
  end

  test 'should redirect not signed in users' do
    sign_out @user
    assert_no_difference('PostLike.count') do
      post post_likes_path(@post)
    end
    assert_redirected_to new_user_session_path
  end
end
