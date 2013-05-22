class AddGmapsToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :gmaps, :boolean #not mandatory, see wiki
  end
end
