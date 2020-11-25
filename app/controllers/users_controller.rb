class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :destroy, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :index]
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @reservations = @user.reservations
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to top_path
      flash[:success] = "さっそく予約してみよう！"
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "ユーザーを編集しました"
      redirect_to @user
    else
      render 'edit'
      flash.now[:danger] = "編集に失敗しました"
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless @user == current_user
  end
end
