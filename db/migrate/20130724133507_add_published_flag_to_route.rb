class AddPublishedFlagToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :published, :boolean
  end
end
