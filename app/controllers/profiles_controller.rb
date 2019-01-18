class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, only: [:show]

  def show
    @tasks    = @user.tasks    # incoming tasks from other users
    @requests = @user.requests # outbound requests from user
    @todos    = @requests.my   # self assigned requests

    if !profile_user_self
      @tasks, @requests = @tasks.from_user(current_user), @requests.to_user(current_user)
    end

  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  # when locking out users from profiles
  def verify_user
    unless @user == current_user
      flash[:error] =  "You do not have access to that profile"
      redirect_to profiles_path(current_user)
    end
  end

  def profile_user_self
    @user == current_user
  end

end
