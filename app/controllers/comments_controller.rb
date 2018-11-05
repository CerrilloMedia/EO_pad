class CommentsController < ApplicationController
  before_action :get_request

  def create
    @comment = @request.comments.build(comment_params)
    @comment.user_id = current_user.id

      if @comment.save
        respond_to do |format|
          format.js
          format.html {
            redirect_to @request
          }
        end
      else
        respond_to do |format|
          format.js
          format.html {
            @comment.errors.full_messages
            flash[:notice] = "Something went wrong, please try again."
            redirect_to @request
          }
        end
      end
  end

  def destroy
    @comment = Comment.find(params[:id])

    puts "destroy: "
    puts params[:id]

    if current_user == @comment.user && @comment.destroy
      respond_to do |format|
        format.js
        format.html {
          redirect_to @request
        }
      end
    else
      respond_to do |format|
        format.js
        format.html {
          flash[:alert] = "There was an error, please try again"
        }
      end
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
