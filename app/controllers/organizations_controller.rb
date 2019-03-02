class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user

  def show
    # @organization = Organization.find(params[:id])
    # obtain all teams within organization
    @organization = Organization.find(params[:id])
  end

  def new
    
  end

  def create
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
end
