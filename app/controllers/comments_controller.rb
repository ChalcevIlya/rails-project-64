# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if params[:parent_id].present?
      @comment.parent = PostComment.find(params[:parent_id])
    end
    Rails.logger.debug @comment.errors.full_messages
    if @comment.save
      redirect_to post_path(@post.id), notice: t('comments.created')
    else
      redirect_to post_path(@post.id), alert: t('comments.not_created')
    end
    Rails.logger.debug @comment.errors.full_messages
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
