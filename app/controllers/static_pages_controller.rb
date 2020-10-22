class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:top]
  def home
  end

  def top
  end

  def staff
  end

  def new_review
    @menus = Menu.all
  end
end
