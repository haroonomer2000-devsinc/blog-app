# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = I18n.t(:authorization)
    redirect_back(fallback_location: root_path)
  end
end
