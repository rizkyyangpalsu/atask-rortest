class User < ApplicationRecord
  has_secure_password
  has_one :wallet, as: :entity, dependent: :destroy
end
