class AddImageToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :image, :string
  end
end
