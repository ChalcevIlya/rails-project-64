# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @posts = Post.includes(:category, :creator).order(created_at: :desc)
  end

  def show
    @post = Post.includes(comments: :user).find(params[:id])
    @likes = @post.likes
    @comments = @post.comments
    @comment = PostComment.new
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: t('posts.created')
    else
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
