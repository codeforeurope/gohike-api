class SimplifyRewards < ActiveRecord::Migration
  def change
    remove_column :rewards, :rewardable_type
    rename_column :rewards, :rewardable_id, :route_id
  end


end
