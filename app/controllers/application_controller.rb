class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Globally rescue Authorization Errors in controller.
  # Returning 403 Forbidden if permission is denied
  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  # Enforces access right checks for individuals resources
  # after_filter :verify_authorized, :except => :index

  # Enforces access right checks for collections
  # after_filter :verify_policy_scoped, :only => :index

  private

  def permission_denied
    flash[:alert] = "Bạn không có quyền truy cập trang này"
    self.response_body = nil # This should resolve the redirect root.
    redirect_to(request.referrer || root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, 
    	keys: [:fullName, :address, :year_birthday, :gender])
  end
end
