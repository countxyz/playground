class Contact < ActiveRecord::Base
  belongs_to :user

  has_many :emails, as: :emailable, dependent: :destroy

  validates_presence_of :first_name

  validates_length_of :first_name,          maximum: 50
  validates_length_of :last_name, :company, maximum: 50,   allow_blank: true
  validates_length_of :notes,               maximum: 1000, allow_blank: true

  default_scope { order(updated_at: :desc) }
end
