class CommentsController < ApplicationController
  before_action :get_request

  def create
    @comment = @request.comments.build(comment_params)
    @comment.user_id = current_user.id

      if @comment.save
        respond_to do |format|
          format.js {
            render layout: false
          }
          format.html {
            redirect_to @request
          }
        end
      else
        @comment.errors.full_messages
        flash[:notice] = "Something went wrong, please try again."
        redirect_to @request
      end
  end

  def destroy
    @comment = @request.comments.find(params[:id])

    if current_user == @comment.user && @comment.destroy
      respond_to do |format|
        format.js {
          render layout: false
        }
        format.html {
          redirect_to @request
        }
      end
    else
      flash[:alert] = "There was an error, please try again"
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
