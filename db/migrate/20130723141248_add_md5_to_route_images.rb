class AddMd5ToRouteImages < ActiveRecord::Migration
  def change
    add_column :routes, :image_mobile_md5, :string
    add_column :routes, :image_icon_md5, :string
    remove_column :routes, :icon

  end
end
