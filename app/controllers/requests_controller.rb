class RequestsController < ApplicationController

  def index
    @requests = Request.all.order(created_ad: :desc)
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

  private

  def request_params
    params.require(:request).permit(:content)
  end
end
