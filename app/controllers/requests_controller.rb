class RequestsController < ApplicationController
  before_action :logged_in_user
  def index
    @requests = Request.all.order(created_at: :desc)
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
    @request = Request.find(params[:id])
  end

  def destroy
    @request = Request.find(params[:id])
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

  def request_params
    params.require(:request).permit(:content)
  end
end
