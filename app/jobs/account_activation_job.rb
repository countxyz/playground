class AccountActivationJob < ActiveJob::Base

  def perform user
    UserMailer.account_activation(user).deliver_now!
  end
end
