class RequestsController < ApplicationController
  before_action :authenticate_user!

  before_action :get_request, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new,:create, :update]

  def index
    @user = current_user
  end

  def show
    @recipient = User.find(@request.recipient.id)
    @user = User.find(@request.user_id)
  end

  def new
    @request = @user.requests.new
    @request.recipient_id = params[:recipient_id] if params[:recipient_id]
    @users = User.all
  end

  def create
    @request = @user.requests.build(request_params)
    @users = User.all

    begin
      if @request.save
        flash[:notice] = "request saved"
        redirect_to @request
      else
        flash[:alert] = "unable to process request, please try again"
        puts @request.errors.full_messages
        render :new
      end
    rescue ActiveRecord::NestedAttributes::TooManyRecords
      flash[:alert] = "Limit reached for availabilies"
      render :new
    end
  end

  def edit
    @user = @request.recipient
  end

  def update
    begin
      if @request.update(request_params)
        flash[:notice] = "request updated"
        redirect_to @request
      else
        @request.errors.full_messages
        flash[:alert] = "unable to update request, please see errors below"
        render :edit
      end
    rescue ActiveRecord::NestedAttributes::TooManyRecords
      flash[:alert] = "Limit reached for availabilies"
      render :edit
    end
  end

  def destroy
    if @request.destroy && current_user.id == @request.user_id
        flash[:notice] = "request removed"
        redirect_to root_path
    else
      flash[:alert] = "unable to delete request"
      render :edit
    end
  end

  private

  def request_params
    params.require(:request).permit(
      :subject,:body,:status, :client_name, :user_id, :recipient_id,
      availabilities_attributes: [:id, :date, :startTime, :endTime, :endDate, :request_id, :_destroy]
    )
  end

  def set_user
    @user = current_user
  end

  def get_request
    @request = Request.find(params[:id])
  end

end
