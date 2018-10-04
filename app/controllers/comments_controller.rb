class CommentsController < ApplicationController
  before_action :get_request

  def new

  end

  def create
    @comment = @request.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to @request
    else
      @comment.errors.full_messages
      flash[:notice] = "Something went wrong, please try again."
      redirect_to @request
    end
  end

  def destroy
    @comment = @request.comments.find(params[:id])

    if current_user == @comment.user && @comment.destroy
      redirect_to @request
    end

  end

  private

  def get_request
    @request = Request.find(params[:request_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
