class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user

  # def index
  #   if current_user
  #     @users = User.where.not('id = ?', current_user.id)
  #   end
  #   @team = Team.find(current_user)
  # end

  def show

  end

  def new
    @team = Team.new()
  end

  def create
    @team = Team.new(request_params)

    if @team.save
      redirect_to request.referrer || @team
    else

    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def get_user
    @user = current_user
  end

  def request_params
    params.require(:team).permit(
      :subject,:body,:status, :client_name, :user_id, :recipient_id
    )
  end


end
