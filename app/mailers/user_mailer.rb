class UserMailer < ApplicationMailer
  default from: 'iconya.app@gmail.com'

  def reset_password_email(user)
    @user = User.find(user.id)
    @url  = edit_password_reset_url(@user.reset_password_token, host: ActionMailer::Base.default_url_options[:host])
    mail(to: user.email,
         subject: 'パスワードリセット')
  end
end