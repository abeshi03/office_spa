class Menu < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many   :reviews, dependent: :destroy
  validates  :name,        presence: true
  validates  :category,    presence: true
  validates  :description, presence: true, length: { maximum: 100 }
  validates  :image, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" },
                            size: { less_than: 5.megabytes, message: "should be less than 5MB" }

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end

  def avg_score
    unless reviews.empty?
      reviews.average(:score).round(1).to_f
    else
      0.0
    end
  end

  def review_score_percentage
    unless reviews.empty?
      reviews.average(:score).round(1).to_f * 100/5
    else
      0.0
    end
  end
end
