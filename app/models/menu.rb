class Menu < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  validates  :name,        presence: true
  validates  :category,    presence: true
  validates  :description, presence: true, length: { maximum: 100 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" },
                            size: { less_than: 5.megabytes, message: "should be less than 5MB" }

  def display_image
    image.variant(resize_to_limit: [200, 200])
  end
end
