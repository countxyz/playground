class Account < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user

  has_one  :note, as: :noteable, dependent: :destroy

  has_many :emails, as: :emailable, dependent: :destroy

  friendly_id :name, use: %w(slugged finders)

  validates_presence_of :name

  validates_length_of :name,    maximum: 50
  validates_length_of :website, in: 6..50,  allow_blank: true

  validates_uniqueness_of :name

  default_scope { order(updated_at: :desc) }

  scope :active_total,   -> { where('active is true').count  }
  scope :inactive_total, -> { where('active is false').count }
end
