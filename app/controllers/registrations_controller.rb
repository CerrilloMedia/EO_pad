class RegistrationsController < Devise::RegistrationsController
  protected

  # def after_sign_in_path_for(resource)
  #   puts resource
  #   profiles_path(current_user)
  # end
end
