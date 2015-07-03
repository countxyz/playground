class AccountActivationJob < ActiveJob::Base
  queue_as :low

  def perform user
    UserMailer.account_activation(user).deliver_now!
  end
end
