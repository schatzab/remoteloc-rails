class LocEdit < ActiveRecord::Base

  belongs_to :user # user is table 1 of the rich join
  belongs_to :loc # loc is table 2 of the rich join	 
 
end