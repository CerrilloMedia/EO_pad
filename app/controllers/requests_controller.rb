class RequestsController < ApplicationController
  before_action :authenticate_user!

  before_action :get_request, only: [:show, :edit, :update, :destroy, :update_status]
  before_action :set_user, only: [:new,:create,:edit,:update, :destroy]

  def index
    @user = current_user
  end

  def show
    @recipient = @request.recipient
    @user = @request.user
    respond_to do |format|
      format.json { render json: @request }
      format.html {
          render layout: 'application'
      }
    end
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
        render :new
      end
    rescue ActiveRecord::NestedAttributes::TooManyRecords
      flash[:alert] = "Limit reached for availabilies"
      render :new
    end
  end

  def edit
    if @user != @request.user && @user != @request.recipient
      flash[:alert] = "you do not have appropriate permission"
      redirect_to @request
    end
  end

  def update

    begin
      if @request.update_attributes(request_params)
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

    if (current_user == @request.user || current_user == @request.recipient) && @request.destroy
        respond_to do |format|
          format.js
          format.html {
            flash[:notice] = "request removed"
            redirect_to profiles_path(current_user)
          }
        end
    else
        respond_to do |format|
          format.js
          format.html {
            flash[:alert] = "unable to delete request"
            render :edit
          }
        end
    end
  end

  def update_status

    @request.status = @request.active? ? "completed" : "active"

    if @request.participants(current_user)

      profile_id = request.referrer.match(/profile\/\d+/) ? request.referrer.match(/profile\/(\d+)/)[1].to_i : current_user.id

      if profile_id
        @user = User.find(profile_id)
      end

      if @request.save
        respond_to do |format|
          format.js {
          }
          format.html {
            flash[:notice] = "Request status updated"
          }
        end
      else
        respond_to do |format|
          format.js {
            # render status: 422
            render status: 422
          }
          format.html {
            flash[:alert] = "unable to process"
          }
        end
      end
    else
      puts "error from non-authorized user"
      puts @request
      respond_to do |format|
        format.js { render status: 422 }
        format.html {
          flash[:alert] = "you do not have the appropriate permissions for this action."
        }
      end
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
