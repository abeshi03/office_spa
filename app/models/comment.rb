class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :request
  validates :comment_content, presence: true, length: { maximum: 100 }
end
