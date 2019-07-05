class User < ApplicationRecord
<<<<<<< HEAD
  VALID_EMAIL_REGEX = Settings.ver

  before_save {email.downcase!}

  validates :name, presence: true, length: { maximum: Settings.name_max }
  validates :email, presence: true, length: { maximum: Settings.email_max }, format: { with: Settings.valid_email_regax }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: Settings.pass_min }
=======
  VALID_EMAIL_REGEX = valid_email_regax

  before_save {email.downcase!}

  validates :name, presence: true, length: { maximum: name_max }
  validates :email, presence: true, length: { maximum: email_max }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: pass_min }
>>>>>>> 56dd3f3... Update C6

  has_secure_password
end
