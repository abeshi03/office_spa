class Menu < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many   :reviews, dependent: :destroy
  has_many   :reservations
  #メニューが誤って削除されても予約は消えないよう、dependentはつけない
  validates  :name,        presence: true
  validates  :category,    presence: true
  validates  :description, presence: true, length: { maximum: 100 }
  validates  :image, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" },
                            size: { less_than: 5.megabytes, message: "should be less than 5MB" }

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end

  def avg_score
    if reviews.empty?
      0.0
    else
      reviews.average(:score).round(1).to_f
    end
  end

  def review_score_percentage
    if reviews.empty?
      0.0
    else
      reviews.average(:score).round(1).to_f * 100 / 5
    end
  end
end
