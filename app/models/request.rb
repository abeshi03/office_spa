class Request < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }
end
