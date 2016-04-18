class Loc < ActiveRecord::Base

  belongs_to :city
  has_many :loc_edits # rich join table
  has_many :users, through: :loc_edits # needed to traverse rich join as well as line above.

  acts_as_list scope: :city
  # lists scoped by page

  # after_save :touch_city --- Come back to this.  #'ed out for add location.

  CONTENT_TYPES = ['text', 'HTML'] #constant allowed to have
	
  # validate location content before submit to db
  validates_presence_of :name # the location field in the DB must have a name
  validates_length_of :name, maximum: 255
  validates_presence_of :content 	# must have some type of content
  validates_presence_of :user_city # must have city from user

  scope :sorted, lambda { order("locs.position ASC") }
  scope :sortedAll, lambda { order("locs.id DESC") }
  scope :visible, lambda { where(visible: true) }
  scope :invisible, lambda { where(visible: false) } 
  scope :newest_first, lambda { order("locs.created_at DESC") }

  private # private means it's not callable from outside this class, only this class has access to it.

  #def touch_city
    #touch is similar to state.update_attribute. will update timestamp.
	#city.touch
  #end
end