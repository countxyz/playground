class UserMailer < ActionMailer::Base
  default from: 'noreply@example.com'

  def account_activation user
    @user = user
    mail to: user.email, subject: 'Account Activation'
  end
end
