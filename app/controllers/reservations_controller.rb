class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user

  def index
    @reservations = Reservation.paginate(page: params[:page]).order(start_time: :desc)
    @reservations_index = Reservation.paginate(page: params[:page]).where("start_time > ?", Date.today).order(start_time: :desc)
  end

  def new
    @reservation = Reservation.new
    @reservations = Reservation.all
  end

  def create
    @reservations = Reservation.all
    @reservation = Reservation.new(reservation_params)
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

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:name, :start_time)
  end
end
