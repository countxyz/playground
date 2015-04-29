class Contact < ActiveRecord::Base
  belongs_to :user

  has_one :note, as: :noteable, dependent: :destroy

  has_many :emails, as: :emailable, dependent: :destroy

  validates_presence_of :first_name, :last_name

  validates_length_of :first_name, :last_name, maximum: 50
  validates_length_of :company,                maximum: 50,   allow_blank: true

  default_scope { order(updated_at: :desc) }

  after_save     :load_into_soulmate
  before_destroy :remove_from_soulmate

  def full_name
    [first_name, last_name].join ' '
  end

  private

  def load_into_soulmate
    loader = Soulmate::Loader.new 'contacts'
    loader.add('term' => full_name, 'id' => self.id, 'data' => {
      'link' => Rails.application.routes.url_helpers.contact_path(self) } )
  end

  def remove_from_soulmate
    loader = Soulmate::Loader.new 'contacts'
    loader.remove 'id' => self.id
  end
end
