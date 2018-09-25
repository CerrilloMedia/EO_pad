class WelcomeController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user

  def index
    if current_user
      @users = User.where.not('id = ?', current_user.id)
    end
  end

  def get_user
    @user = current_user
  end
end
