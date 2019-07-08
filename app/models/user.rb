class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.ver
  before_save {email.downcase!}

  validates :name, presence: true, length: { maximum: Settings.name_max }
  validates :email, presence: true, length: { maximum: Settings.email_max }, format: { with: Settings.valid_email_regax }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: Settings.pass_min }

   has_secure_password

   # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
