class Account < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user

  has_one  :note, as: :noteable, dependent: :destroy

  has_many :fax_phones,    as: :phoneable, dependent: :destroy
  has_many :home_phones,   as: :phoneable, dependent: :destroy
  has_many :mobile_phones, as: :phoneable, dependent: :destroy
  has_many :office_phones, as: :phoneable, dependent: :destroy
  has_many :toll_phones,   as: :phoneable, dependent: :destroy

  has_many :emails, as: :emailable, dependent: :destroy
  has_many :phones, as: :phoneable, dependent: :destroy

  friendly_id :name, use: %w(slugged finders)

  validates_presence_of :name

  validates_length_of :name,    maximum: 50
  validates_length_of :website, in: 6..50,  allow_blank: true

  validates_uniqueness_of :name

  default_scope { order(updated_at: :desc) }

  scope :active_total,   -> { where('active is true').count  }
  scope :inactive_total, -> { where('active is false').count }

  after_save     :load_into_soulmate
  before_destroy :remove_from_soulmate

  private

  def load_into_soulmate
    loader = Soulmate::Loader.new 'accounts'
    loader.add('term' => name, 'id' => self.id, 'data' => {
      'link' => Rails.application.routes.url_helpers.account_path(self) } )
  end

  def remove_from_soulmate
    loader = Soulmate::Loader.new 'accounts'
    loader.remove 'id' => self.id
  end
end
