class AddTopLeftLatitudeTopLeftLongitudeBottomRightLatitudeBottomRightLongitudeToCities < ActiveRecord::Migration
  def change
    add_column :cities, :top_left_lat, :float
    add_column :cities, :top_left_lon, :float
    add_column :cities, :bottom_right_lat, :float
    add_column :cities, :bottom_right_lon, :float
  end
end
