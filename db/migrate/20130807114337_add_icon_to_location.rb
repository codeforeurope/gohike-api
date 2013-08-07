class AddIconToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :image_icon_md5, :string
  end
end
