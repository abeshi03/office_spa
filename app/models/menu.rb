class Menu < ApplicationRecord
  validates :name,        presence: true
  validates :category,    presence: true
  validates :description, presence: true, length: { maximum: 100 }
end
