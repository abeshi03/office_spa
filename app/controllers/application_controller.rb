class ApplicationController < ActionController::Base
  include SessionsHelper
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしていません"
      redirect_to login_url
    end
  end

  def admin_user
    redirect_to top_path unless current_user.admin?
  end
end
