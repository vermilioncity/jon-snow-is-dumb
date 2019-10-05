class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email

  end

  def password_reset(user)
    @user = user
    mail to: user.email
  end

  def send_new_post_notification(user, article)
    @user = user
    @article = article
    mail to: user.email
  end
end
