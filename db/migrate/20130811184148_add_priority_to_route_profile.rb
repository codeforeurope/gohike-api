class AddPriorityToRouteProfile < ActiveRecord::Migration
  def change
    add_column :route_profiles, :priority, :integer, :default => 0
  end
end
