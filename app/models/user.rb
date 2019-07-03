class User < ApplicationRecord
  VALID_EMAIL_REGEX = valid_email_regax
  before_save {email.downcase!}
  validates :name, presence: true, length: { maximum: name_max }
  validates :email, presence: true, length: { maximum: email_max }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: pass_min }
  has_secure_password
  
end
