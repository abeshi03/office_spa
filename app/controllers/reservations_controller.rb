class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :set_reservations, only: [:new, :create]

  def index
    @reservations = Reservation.paginate(page: params[:page])
    @reservations_index = @reservations.future_reservations
  end

  def new
    @reservation = Reservation.new
    @user = User.find_by(id: current_user.id)
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @user = User.find_by(id: current_user.id)
    if @reservation.save
      flash[:success] = "予約を完了しました"
      redirect_to reservations_path
    else
      render "reservations/new"
    end
  end

  def destroy
    @reservation.destroy
    flash[:success] = "予約を削除しました"
    redirect_to reservations_path
  end

  private

  def set_reservations
    @reservations = Reservation.all
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:name, :start_time, :user_id)
  end
end
