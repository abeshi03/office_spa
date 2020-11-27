class RequestsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy]
  before_action :set_request,  only: [:show, :destroy]
  def index
    @requests = Request.paginate(page: params[:page])
  end

  def new
    @request = Request.new
  end

  def create
    @request = current_user.requests.build(request_params)
    if @request.save
      flash[:success] = "要望が投稿されました"
      redirect_to requests_path
    else
      render "new"
    end
  end

  def show
    @comment = Comment.new
    @comments = @request.comments
  end

  def destroy
    if @request&.user_id == current_user.id
      @request.destroy
      redirect_to requests_path
      flash[:success] = "要望を削除しました"
    else
      flash[:danger] = "こちらの要望は削除できません"
      redirect_to top_path
    end
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:content)
  end

  def correct_user
    @request = current_user.requests.find_by(id: params[:id])
    redirect_to top_path if @request.nil?
  end
end
