class AddMd5ToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :image_mobile_md5, :string

  end
end
