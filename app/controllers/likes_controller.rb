# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    like = @post.likes.build(user: current_user)
    if like.save
      redirect_to root_path(anchor: "post-#{@post.id}"), notice: t('posts.liked')
    else
      redirect_to root_path(anchor: "post-#{@post.id}"), alert: like.errors.full_messages.to_sentence
    end
  end

  def destroy
    like = @post.likes.find_by(user: current_user)
    if like
      like.destroy
      redirect_to root_path(anchor: "post-#{@post.id}"), notice: t('posts.unliked')
    else
      redirect_to root_path(anchor: "post-#{@post.id}"), alert: t('posts.like_not_found')
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
