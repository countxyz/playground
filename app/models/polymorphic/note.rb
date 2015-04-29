class Note < ActiveRecord::Base
  belongs_to :noteable, polymorphic: true

  validates_length_of :note, maximum: 1000

  validates_presence_of :note
end
