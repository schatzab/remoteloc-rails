class State < ActiveRecord::Base

  has_many :cities

  acts_as_list 
	
  validates :name, presence: true # state field in the DB MUST have a name value
  validates_length_of :name, maximum: 255
  #gives a diff error message, can't be more than 255 chars

  
  scope :visible, lambda { where(visible: true) }
  scope :invisible, lambda { where(visible: false) } 
  scope :sorted, lambda { order("states.position ASC") }
  scope :newest_first, lambda { order("states.created_at DESC") }
  scope :search, lambda { |query|
    where (["name LIKE ?", "%#{query}%"]) 
  }
end