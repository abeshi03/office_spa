class Review < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  validates  :score,   presence: true
  validates  :content, presence: true, length: { maximum: 300 }
end
