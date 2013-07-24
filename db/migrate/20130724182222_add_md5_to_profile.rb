class AddMd5ToProfile < ActiveRecord::Migration
  def change
    add_column :route_profiles, :image_icon_md5, :string
    remove_column :route_profiles, :icon
  end
end
