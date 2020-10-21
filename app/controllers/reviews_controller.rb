class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  def index
    @menu = Menu.find(params[:menu_id])
    @reviews = @menu.reviews
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to menu_reviews_path(@review.menu)
    else
      @menu = Menu.find(params[:menu_id])
      render "menus/show"
    end
  end

  private
  def review_params
    params.require(:review).permit(:menu_id, :score, :content)
  end
end