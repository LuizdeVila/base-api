class User < ApplicationRecord
  has_secure_password

  has_one_attached :avatar

  with_options presence: true do
    validates :name
    validates :email, uniqueness: true
    validates :password_digest
  end
end
