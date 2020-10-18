class Menu < ApplicationRecord
  belongs_to :user
  validates :name,        presence: true
  validates :category,    presence: true
  validates :description, presence: true, length: { maximum: 100 }
end
