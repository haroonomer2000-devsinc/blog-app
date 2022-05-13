class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    if !@comment.save
      flash[:alert] = @comment.errors.full_messages.to_sentence
    end
    redirect_to post_path(params[:post_id])
  end

  def destroy 
    print(params)
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:post).permit(:body, :parent_id, files: []).merge(post_id: params[:post_id])
  end
end
