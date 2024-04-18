class ApplicationController < ActionController::Base
  include Authentication
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :current_user
  helper_method :current_user
  helper_method :user_signed_in?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
