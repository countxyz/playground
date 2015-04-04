class Task < ActiveRecord::Base
  belongs_to :user

  validates_length_of :description, maximum: 200

  validates_presence_of :description
end
