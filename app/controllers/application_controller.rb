class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Global controllers method to check if user is admin
  def authenticate_admin!
    unless current_user.admin?
      render json: { error: 'Access denied' }, status: :unauthorized
    end
  end

  private

  # Parameters allowed when signing up user
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :role])
  end
end
