class Request < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites
  has_many :users_favorite, through: :favorites
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }
end
