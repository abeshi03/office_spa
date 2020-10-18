class Menu < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  validates  :name,        presence: true
  validates  :category,    presence: true
  validates  :description, presence: true, length: { maximum: 100 }
end
