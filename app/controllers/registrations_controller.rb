# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(_resource)
    confirmation_home_index_path # Or :prefix_to_your_route
  end

  def after_inactive_sign_up_path_for(_resource)
    confirmation_home_index_path # Or :prefix_to_your_route
  end
end
