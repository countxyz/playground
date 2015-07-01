module Authenticationable
  extend ActiveSupport::Concern

  attr_accessor :password, :activation_token

  included do
    before_create :create_activation_digest
  end

  def password=(unencrypted_password)
    @password            = unencrypted_password
    self.password_digest = digest(unencrypted_password)
  end

  def password_confirmation=(unencrypted_password)
    @password_confirmation = unencrypted_password
  end

  def activate
    update_attribute :activated,    true
    update_attribute :activated_at, Time.zone.now
  end

  def authenticate unencrypted_password
    SCrypt::Password.new(password_digest) == unencrypted_password && self
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    SCrypt::Password.new(digest).is_password? token unless digest.nil?
  end

  def activated_authentication? token
    self.activated && authenticate(token)
  end

  def digest string
    SCrypt::Password.create string
  end

  def new_token
    SecureRandom.urlsafe_base64
  end

  private

  def create_activation_digest
    self.activation_token  = new_token
    self.activation_digest = digest activation_token
  end
end
