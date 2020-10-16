class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:top]
  def home
  end

  def top
  end
end
