class Review < ApplicationRecord
  belongs_to :user
  belongs_to :menu
end
