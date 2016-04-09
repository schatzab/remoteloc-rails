class State < ActiveRecord::Base

	has_many :cities #one-to-many association

	acts_as_list # this will add in all the methods of this gem
	
	validates_presence_of :name # This says that the state field in the DB MUST have a name value, otherwise it can't be created or updated.
	validates_length_of :name, :maximum => 255
	#gives a diff error message, can't be more than 255 chars, including white space.

	# scope lets us make custom methods we can use on this table to check if visible, or to sort, etc
	scope :visible, lambda { where(:visible => true) }
	scope :invisible, lambda { where(:visible => false) } 
	# in rails console I can call subject.invisible and get all my states that have visible as false
	scope :sorted, lambda { order("states.position ASC") }
	scope :newest_first, lambda { order("states.created_at DESC") }
	scope :search, lambda { |query|
		where (["name LIKE ?", "%#{query}%"]) # using array syntax instead of the hash syntax above.  Just another option
		# at the end we could put in "query" by itself, but by using the % wildcards it can find it anywhere.
	}
end
