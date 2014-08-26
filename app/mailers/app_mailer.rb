
class AppMailer < ActionMailer::Base

  default from: 'notifications@example.com', bcc: 'mmartin@levsrin.com'

  def reset_password_email(user)
    @user = user
    email_with_name = "#{@user.full_name} <#{@user.email_address}>"
    @url  = 'http://example.com/signin'
    mail(to: email_with_name, subject: 'Password Reset')
  end
end
