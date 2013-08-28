class AddChecksumToReward < ActiveRecord::Migration
  def change
    add_column :rewards, :image_md5, :string
  end
end
