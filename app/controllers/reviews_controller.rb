class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  def index
    @menu = Menu.find(params[:menu_id])
    @reviews = @menu.reviews.order(created_at: :desc)
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to menu_reviews_path(@review.menu)
      flash[:success] = "口コミを投稿しました"
    else
      @menu = Menu.find(params[:menu_id])
      render "menus/show"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:success] = "口コミを削除しました"
    redirect_to menus_path
  end

  private
  
  def review_params
    params.require(:review).permit(:menu_id, :score, :content)
  end
end
