class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: t"acc-act"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: t"pass-reset"
  end
end
