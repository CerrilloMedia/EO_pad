class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user

  def show
    @requests = @user.requests  # requests which user has assigned to others
    @tasks    = @user.tasks     # requests which have been assigned to user
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def check_user
    unless @user == current_user
      # redirect_to profiles_path(current_user)
      flash[:alert] =  "You do not have access to that profile"
    end
  end

end
