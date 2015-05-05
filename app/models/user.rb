class User < ActiveRecord::Base
  attr_accessor :password

  has_one :fax_phone, as: :phoneable, dependent: :destroy

  has_many :accounts, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :tasks,    dependent: :destroy

  has_many :home_phones,   as: :phoneable, dependent: :destroy
  has_many :mobile_phones, as: :phoneable, dependent: :destroy

  has_many :phones, as: :phoneable, dependent: :destroy

  EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  validates_confirmation_of :password

  validates_format_of   :email, with: EMAIL_REGEX

  validates_length_of :first_name, :last_name, maximum: 50, allow_blank: true
  validates_length_of :email,    in: 5..50
  validates_length_of :password, in: 8..128

  validates_presence_of :email, :password

  validates_uniqueness_of :email, case_sensitive: false

  before_save :downcase_email

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

  private

  def downcase_email
    self.email = email.downcase
  end
end
