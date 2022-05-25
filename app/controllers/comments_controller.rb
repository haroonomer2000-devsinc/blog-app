# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = current_user.comments.new(comment_params.merge(post_id: params[:post_id]))
    flash[:alert] = @comment.errors.full_messages.to_sentence unless @comment.save
    redirect_to post_path(params[:post_id])
  end

  def update
    @comment.status = params[:status]
    @comment.save
    redirect_to post_path(params[:post_id])
  end

  def destroy
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
    unless @comment 
      flash[:notice] = I18n.t(:resource_not_found)
      redirect_to posts_path
    end
  end

  def comment_params
    params.require(:post).permit(:body, :parent_id, files: [])
  end
end
