class AddCityToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :city_id, :integer
  end
end
