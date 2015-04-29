class Contact < ActiveRecord::Base
  belongs_to :user

  has_one :note, as: :noteable, dependent: :destroy

  has_many :emails, as: :emailable, dependent: :destroy

  validates_presence_of :first_name, :last_name

  validates_length_of :first_name, :last_name, maximum: 50
  validates_length_of :company,                maximum: 50,   allow_blank: true

  default_scope { order(updated_at: :desc) }

  def full_name
    [first_name, last_name].join ' '
  end
end
