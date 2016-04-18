 class City < ActiveRecord::Base

  belongs_to :state
  has_many :locs
  # make my db Join Table connection between User and City
  has_and_belongs_to_many :users

  acts_as_list scope: :state
  # acts_as_list will check on the positions based on the subject id.

  # Callbacks:
  before_validation :add_default_permalink # see method at bottom, before validations a few lines below it will make up a default permalink if none is provided.
  after_save :touch_state #this will affect both Create and Update!  See bottom of page

  # after_destroy :delete_related_sections # see bottom of page - NOT USING

  # Order is important - error messages will give error of name, before length in this case:
  validates_presence_of :name # This says that the state field in the DB MUST have a name value, otherwise it can't be created or updated.
  validates_length_of :name, maximum: 255
  validates_presence_of :permalink
  validates_length_of :permalink, within: 3..255 #sets min of 3 and max of 255
  # presence and length combo disallows spaces
  validates_uniqueness_of :permalink
  # for unique values by state use "scope: :subject_id"

  scope :sorted, lambda { order("cities.name ASC") } # show cities in alpha order
  scope :visible, lambda { where(visible: true) }
  scope :invisible, lambda { where(visible: false) } 
  scope :newest_first, lambda { order("cities.created_at DESC") }

  private # private means it's not callable from outside this class, only this class has access to it.
    def add_default_permalink
	  if permalink.blank? #if the permalink is blank...
	    self.permalink = "#{id}-#{name.parameterize}" #set the permalink to the id - name (parameterize will make the name safe - no symbols or weird url stuff)
	  end
	end
	def touch_state
	  #touch is similar to state.update_attribute. will update timestamp.
	  state.touch
	end
end