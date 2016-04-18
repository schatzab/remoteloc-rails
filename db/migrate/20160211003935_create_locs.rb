class CreateLocs < ActiveRecord::Migration
  def change # change can be used here instead of up as all the commands can be reversible (only create DB and create index)
    create_table :locs do |t|
    	t.integer "city_id" # this is the foreign key
	 	t.string "name"
	 	t.integer "position"
	 	t.boolean "visible", default: false
	 	t.text "content" #the content itself
      	t.timestamps
    end
    add_index("locs", "city_id")
  end
end