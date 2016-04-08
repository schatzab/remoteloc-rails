class CreateLocEdits < ActiveRecord::Migration
  def change
    create_table :loc_edits do |t|
    	# have two foreign keys to join the two other database tables. This will auto-add the _id.
    	t.references :user
    	t.references :loc
    	t.string :summary #can have a summary for every edit
      t.timestamps
    end
    # need index with foreign key
    add_index :loc_edits, ["user_id", "loc_id"]
  end
end
