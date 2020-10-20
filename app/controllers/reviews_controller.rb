class ReviewsController < ApplicationController
  def index
    @menu = Menu.find(params[:menu_id])
    @reviews = @menu.reviews
  end

  def show
    @menu = Review.find(params[:id])
    @review = Review.new
  end
end
