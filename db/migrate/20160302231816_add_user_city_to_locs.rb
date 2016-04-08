class AddUserCityToLocs < ActiveRecord::Migration
  def up
  	add_column "locs", "user_city", :string, :limit => 100
  end

  def down
  	remove_column "locs", "user_city"
  end
end
