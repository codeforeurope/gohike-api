class ChangePublishedRoute < ActiveRecord::Migration
  def up
    remove_column :routes, :published
    add_column :routes, :published_key, :string
  end

  def down
    add_column :routes, :published, :boolean
    remove_column :routes, :published_key
  end
end
