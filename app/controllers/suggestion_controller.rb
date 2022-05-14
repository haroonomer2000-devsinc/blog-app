class SuggestionController < ApplicationController
  def create 
    print("Suggestion__params===>",suggestion_params)
    @suggestion = current_user.suggestions.new(suggestion_params.merge(post_id: params[:post_id]))
    if !@suggestion.save
      flash[:alert] = @comment.errors.full_messages.to_sentence
    end
    redirect_to post_path(params[:post_id])
  end
  
  private
  
  def suggestion_params
    params.require(:post).permit(:to_replace, :replacement)
  end
end
