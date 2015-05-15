module Authenticationable
  extend ActiveSupport::Concern

  attr_accessor :password

  def password=(unencrypted_password)
    @password            = unencrypted_password
    self.password_digest = SCrypt::Password.create(unencrypted_password)
  end

  def password_confirmation=(unencrypted_password)
    @password_confirmation = unencrypted_password
  end

  def authenticate unencrypted_password
    SCrypt::Password.new(password_digest) == unencrypted_password && self
  end
end
