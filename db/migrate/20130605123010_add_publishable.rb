class AddPublishable < ActiveRecord::Migration
  def change
    add_column :routes, :is_publishable, :boolean
    add_column :route_profiles, :is_publishable, :boolean
  end


end
