 class City < ActiveRecord::Base

  belongs_to :state
  has_many :locs
  # Join Table connection between User and City
  has_and_belongs_to_many :users

  acts_as_list scope: :state
  # check on the positions based on the subject id.

  # Callbacks:
  before_validation :add_default_permalink # see method at bottom, before validations a few lines below it will make up a default permalink if none is provided.
  after_save :touch_state #this will affect both Create and Update!  See bottom of page

  # Order is important
  validates :name, presence: true # state field in the DB MUST have a name value
  validates_length_of :name, maximum: 255
  validates :permalink, presence: true
  validates_length_of :permalink, within: 3..255 #sets min of 3 and max of 255
  # presence and length combo disallows spaces
  validates_uniqueness_of :permalink
  # for unique values by state use "scope: :subject_id"

  scope :sorted, lambda { order("cities.name ASC") } 
  scope :visible, lambda { where(visible: true) }
  scope :invisible, lambda { where(visible: false) } 
  scope :newest_first, lambda { order("cities.created_at DESC") }

  private # only this class has access to
    def add_default_permalink
	  if permalink.blank? #if the permalink is blank...
	    self.permalink = "#{id}-#{name.parameterize}" #set the permalink to the id - name (parameterize will make the name safe )
	  end
	end
	def touch_state
	  # will update timestamp.
	  state.touch
	end
end