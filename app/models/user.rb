require 'digest'

class User < ApplicationRecord

  attr_accessor :remember_token

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

  class << self

    def digest(string)

      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    if remember_digest.nil?
      false
    else
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
  end

  # Remembers a user in the database for use in persistent sessions.

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

end
