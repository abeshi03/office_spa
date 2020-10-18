class MenusController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only[:new, :create, :destroy]

  def index
    @menus = Menu.all
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      redirect_to menus_path
      flash[:success] = "メニューが作成されました"
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    if current_user.admin?
      @menu.destroy
      flash[:success] = "メニューを削除しました"
      redirect_to menus_path
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :category, :description)
  end
end
