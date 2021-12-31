class User < ApplicationRecord
  has_secure_password
  
  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true
end
