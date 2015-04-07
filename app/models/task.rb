class Task < ActiveRecord::Base
  belongs_to :user

  validates_length_of :description, maximum: 200
  validates_length_of :title,       maximum: 50

  validates_presence_of :description, :title

  default_scope { where(complete: false) }
  default_scope { order(deadline: :asc)  }
end
