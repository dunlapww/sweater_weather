class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :api_key, presence: true
  validates :api_key, uniqueness: true
end
