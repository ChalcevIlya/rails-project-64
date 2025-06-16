# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @root_comment = post_comments(:root_comment)
    @reply_comment = post_comments(:reply_comment)

    sign_in @user
  end

  test 'should create root comment' do
    assert_difference('PostComment.count', 1) do
      post post_comments_path(@post), params: {
        post_comment: {
          content: @root_comment.content
        }
      }
    end

    assert_redirected_to post_path(@post.id)
    follow_redirect!
    assert_match I18n.t('comments.created'), response.body
  end

  test 'should create reply comment' do
    assert_difference('PostComment.count', 1) do
      post post_comments_path(@post), params: {
        post_comment: {
          content: @reply_comment,
          parent_id: @root_comment.id
        }
      }
    end

    comment = PostComment.last
    assert_equal @root_comment, comment.parent
    assert_redirected_to post_path(@post.id)
  end

  test 'should not create invalid comment' do
    assert_no_difference('PostComment.count') do
      post post_comments_path(@post), params: {
        post_comment: {
          content: ''
        }
      }
    end

    assert_redirected_to post_path(@post.id)
    follow_redirect!
    assert_match I18n.t('comments.not_created'), response.body
  end
end
