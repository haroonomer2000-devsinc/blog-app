# frozen_string_literal: true

class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: %i[apply destroy remove]

  def create
    @suggestion = current_user.suggestions.new(suggestion_params.merge(post_id: params[:post_id]))
    flash[:alert] = @suggestion.errors.full_messages.to_sentence unless @suggestion.save
    redirect_to post_path(params[:post_id])
  end

  def apply
    @post = Post.find(params[:post_id])
    @post.apply_suggestion(@suggestion)
    @suggestion.destroy
    redirect_to post_path(params[:post_id])
  end

  def destroy
    @suggestion.destroy
    redirect_to post_path(params[:post_id])
  end

  def remove
    @suggestion.destroy
    redirect_to by_user_suggestions_path
  end

  def by_user
    @suggestions = current_user.suggestions
  end

  private

  def set_suggestion 
    @suggestion = Suggestion.find(params[:id])
  end

  def suggestion_params
    params.require(:post).permit(:to_replace, :replacement)
  end
end
