class Loc < ActiveRecord::Base

  belongs_to :city
  has_many :loc_edits # rich join table
  has_many :users, through: :loc_edits # needed to traverse rich join

  acts_as_list scope: :city
  # lists scoped by page

  CONTENT_TYPES = ['text', 'HTML'] #constant allowed to have
	
  # validate location content before submit to db
  validates :name, presence: true # the location field in the DB must have a name
  validates_length_of :name, maximum: 255
  validates :content, presence: true 	# must have some type of content
  validates :user_city, presence: true # must have city from user

  scope :sorted, lambda { order("locs.position ASC") }
  scope :sortedAll, lambda { order("locs.id DESC") }
  scope :visible, lambda { where(visible: true) }
  scope :invisible, lambda { where(visible: false) } 
  scope :newest_first, lambda { order("locs.created_at DESC") }
end