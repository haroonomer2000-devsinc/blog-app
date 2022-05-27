# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = current_user.comments.new(comment_params.merge(post_id: params[:post_id]))
    flash[:alert] = if @comment.save
                      I18n.t(:comment_created)
                    else
                      @comment.errors.full_messages.to_sentence
                    end
    redirect_to post_path(params[:post_id])
  end

  def update
    authorize @comment
    @comment.status = params[:status]
    flash[:alert] = if @comment.save
                      I18n.t(:comment_updated)
                    else
                      @comment.errors.full_messages.to_sentence
                    end
    redirect_to post_path(params[:post_id])
  end

  def destroy
    authorize @comment
    flash[:alert] = if @comment.destroy
                      I18n.t(:comment_deleted)
                    else
                      @comment.errors.full_messages.to_sentence
                    end
    redirect_to post_path(params[:post_id])
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
    return unless @comment.nil?

    flash[:notice] = I18n.t(:resource_not_found)
    redirect_to posts_path
  end

  def comment_params
    params.require(:post).permit(:body, :parent_id, files: [])
  end
end
