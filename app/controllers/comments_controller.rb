class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    print("idfaf'adfkap'idjf eiw2381029840184 x1384",comment_params[:parent_id])
    if !@comment.save
      flash[:alert] = @comment.errors.full_messages.to_sentence
    end
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:post).permit(:body, :parent_id).merge(post_id: params[:post_id])
  end
end
