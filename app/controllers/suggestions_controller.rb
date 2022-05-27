# frozen_string_literal: true

class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: %i[apply destroy]

  def index
    @suggestions = current_user.suggestions
  end

  def create
    @suggestion = current_user.suggestions.new(suggestion_params.merge(post_id: params[:post_id]))
    flash[:alert] = @suggestion.errors.full_messages.to_sentence unless @suggestion.save
    redirect_to post_path(params[:post_id])
  end

  def apply
    @post = Post.find(params[:post_id])
    @post.apply_suggestion(@suggestion)
    flash[:alert] = if @post.save
                      I18n.t(:suggestion_applied)
                    else
                      I18n.t(:suggestion_not_applied)
                    end
    @suggestion.destroy
    redirect_to post_path(params[:post_id])
  end

  def destroy
    flash[:alert] = if @suggestion.destroy
                      I18n.t(:suggestion_destroy)
                    else
                      @suggestion.errors.full_messages.to_sentence
                    end
    redirect_to request.referer
  end

  private

  def set_suggestion
    @suggestion = Suggestion.find_by(id: params[:id])
    return unless @suggestion.nil?

    flash[:notice] = I18n.t(:resource_not_found)
    redirect_to posts_path
  end

  def suggestion_params
    params.require(:post).permit(:to_replace, :replacement)
  end
end
