# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.includes(comments: :user).order(created_at: :desc)
    @post = Post.new
    @categories = Category.all
    @post_comment = PostComment.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, notice: t('posts.created')
    else
      @posts = Post.order(created_at: :desc)
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
