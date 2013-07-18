class AddCityToProfilesAndRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :city_id, :integer
    add_column :route_profiles, :city_id, :integer
  end
end
