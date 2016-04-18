class CreateCities < ActiveRecord::Migration
  def up
    create_table :cities do |t|
    	t.integer "state_id" #foreign key, lets pages know what parent state is
	 	t.string "name", limit: 255
	 	t.string "permalink", limit: 255
	 	t.integer "position"
	 	t.boolean "visible", default: false
      	t.timestamps
    end
    add_index("cities", "state_id") # and index on my foreign key. all foreign keys should always have an index
    add_index("cities", "permalink") # looking up pages through the URL
  end

  def down
  	drop_table :cities
  end
end
