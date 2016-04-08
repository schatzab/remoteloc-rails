class CreateCitiesUsersJoin < ActiveRecord::Migration
  def change
  	# make sure to surpress the id
    create_table :cities_users, :id => false do |t|
    	t.integer "city_id"
    	t.integer "user_id"
    end
    add_index :cities_users, ["city_id", "user_id"]
  end
end
