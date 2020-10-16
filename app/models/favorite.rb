class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :request
  validates_uniqueness_of :request_id, scope: :user_id
end
