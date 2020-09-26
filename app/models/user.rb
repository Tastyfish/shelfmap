class User < ApplicationRecord
  # bcrypt support
  has_secure_password
end
