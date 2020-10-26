class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    @user = current_user
    @request = Request.find(params[:request_id])
    if Favorite.create(user_id: @user.id, request_id: @request.id)
      redirect_to @request
    else
      redirect_to top_path
    end
  end

  def destroy
    user = current_user
    request = Request.find(params[:request_id])
    if favorite == Favorite.find_by(user_id: user.id, request_id: request.id)
      favorite.delete
      redirect_to request
    else
      redirect_to top_path
    end
  end
end
