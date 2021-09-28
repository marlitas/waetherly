class User < ApplicationRecord
  has_many :api_keys
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
