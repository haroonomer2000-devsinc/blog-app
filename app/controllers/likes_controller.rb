class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    unless @like.save
      flash[:notice] = @like.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: posts_url)
  end

  # like/like_id
  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: posts_url)
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
