class AddProfileIdToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :route_profile_id, :integer

    add_index :routes, :route_profile_id

  end
end
