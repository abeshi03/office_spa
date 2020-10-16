class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.request_id = params[:request_id]
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_to @comment.request
    else
      @request = Request.find(params[:request_id])
      @comments = @request.comments
      render template: 'requests/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_to @comment.request
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
