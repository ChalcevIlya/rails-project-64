# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @category = categories(:two)
    @post_params = {
      title: 'Test post title',
      body: 'Test post body',
      category_id: @category.id
    }
  end

  test 'should get index' do
    get posts_url
    assert_response :success
    assert_select 'h1', I18n.t('posts.list')
  end

  test 'should show post' do
    post = posts(:one)

    get post_url(post)
    assert_response :success
    assert_select 'h1', text: post.title
    assert_select 'p', text: post.body
  end

  test 'should create valid post' do
    sign_in @user
    assert_difference('Post.count', 1) do
      post posts_url, params: { post: @post_params }
    end
    created = Post.find_by(@post_params.merge(creator_id: @user.id))
    assert { created }
    assert_redirected_to post_path(created)
    follow_redirect!
    assert_select '.alert.alert-info', text: I18n.t('posts.created')
  end

  test 'should not create invalid post' do
    sign_in @user
    invalid_params = @post_params.merge(title: '', body: '   ')
    assert_no_difference('Post.count') do
      post posts_url, params: { post: invalid_params }
    end
    assert_response :unprocessable_entity
  end
end
