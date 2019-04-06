class User < ApplicationRecord

  before_save { email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  PASSWORD_VALIDATOR = /((?:(?=.*\d)(?=.*[a-z])(?=.*[A-Z])).*)/
  validates :password, presence: true, length: {minimum: 6, maximum: 16},
                       format: { with: PASSWORD_VALIDATOR,
                                 message: 'Password must contain an uppercase letter, lowercase letter, and number'}

  USERNAME_VALIDATOR = /[^a-zA-Z0-9_]/
  validates :username, presence: true, length: { maximum: 15 },
            format: { without: USERNAME_VALIDATOR,
                      message: 'Username must contain only letters, numbers or underscores'}

  has_secure_password
end
