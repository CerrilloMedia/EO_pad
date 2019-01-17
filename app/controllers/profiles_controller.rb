class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, :verify_user, only: [:show]

  def show
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def verify_user
    unless @user == current_user
      flash[:error] =  "You do not have access to that profile"
      redirect_to profiles_path(current_user)
    end
  end

end
