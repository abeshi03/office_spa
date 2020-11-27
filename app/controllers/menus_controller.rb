class MenusController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: [:new, :create, :destroy]
  before_action :set_menu, only: [:show, :destroy]

  def index
    @menus = Menu.all
  end

  def new
    @menu = Menu.new
  end

  def show
    @review = Review.new
  end

  def create
    @menu = current_user.menus.build(menu_params)
    @menu.image.attach(params[:menu][:image])
    if @menu.save
      redirect_to menus_path
      flash[:success] = "メニューが作成されました"
    else
      render "new"
    end
  end

  def destroy
    @menu.destroy
    flash[:success] = "メニューを削除しました"
    redirect_to menus_path
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :description, :category, :image)
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end
end
