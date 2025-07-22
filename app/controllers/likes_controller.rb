# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    set_post
    like = @post.likes.build(user: current_user)
    if like.save
      redirect_to post_path(@post.id), notice: t('posts.liked')
    else
      redirect_to post_path(@post.id), alert: t('posts.likes_too_fast')
    end
  end

  def destroy
    set_post
    like = @post.likes.find_by(user: current_user)
    if like
      like.destroy
      redirect_to post_path(@post.id), notice: t('posts.unliked')
    else
      redirect_to post_path(@post.id), alert: t('posts.like_not_found')
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
