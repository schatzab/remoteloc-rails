class AddLocDetailToLocEdits < ActiveRecord::Migration
  def up
  	add_column "loc_edits", "star_rating", :integer, limit: 5, default: 0
  	add_column "loc_edits", "wifi", :boolean, default: false
  	add_column "loc_edits", "punch_card", :boolean, default: false
  end

  def down
  	remove_column "loc_edits", "punch_card"
  	remove_column "loc_edits", "wifi"
    remove_column "loc_edits", "star_rating"
  end
end