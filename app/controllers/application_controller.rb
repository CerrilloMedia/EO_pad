class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname])
  end

  def after_sign_in_path_for(resource)
    if current_user.class.name == "User"
      profiles_path(current_user)
    elsif resource.class.name == "AdminUser"
      admin_admin_path
    else
      super
    end
  end

end
