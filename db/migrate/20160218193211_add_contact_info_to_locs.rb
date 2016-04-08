class AddContactInfoToLocs < ActiveRecord::Migration
  def up
  	add_column "locs", "address", :string
  	add_column "locs", "phone", :string
  	add_column "locs", "website", :string
  end

  def down
  	remove_column "locs", "website"
  	remove_column "locs", "phone"
  	remove_column "locs", "address"
  end
end