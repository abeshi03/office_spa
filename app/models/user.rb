class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 200 },
                    format: { with: Const::VALID_EMAIL_REGEX },
                    uniqueness: true
end