class RequestsController < ApplicationController

  before_action :get_request, only: [:show, :edit, :update, :destroy]

  def index
    @requests = Request.all
  end

  def show
    # @request = Request.find(params[:id])
  end

  def new
    @request = Request.new
  end


  def create
    @request = Request.new(request_params)
    puts @request
    if @request.save
      flash[:notice] = "request saved"
      redirect_to @request
    else
      puts @request.errors
      flash[:alert] = "unable to process request, please try again"
      render :new
    end
  end

  def edit
  end

  def update
    if @request.update!(request_params)
      flash[:notice] = "request updated"
      redirect_to @request
    else
      puts @request.errors
      flash[:alert] = "unable to process request, please try again"
      render :edit
    end
  end

  def destroy
    if @request.destroy
        flash[:notice] = "request removed"
        redirect_to root_path
    else
      flash[:alert] = "unable to delete request"
      render :edit
    end
  end

  private

  def request_params
    params.require(:request).permit(:subject,:body,:status, :client_name )
  end

  def get_request
    @request = Request.find(params[:id])
  end

end
