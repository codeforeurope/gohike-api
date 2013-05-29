class AddDeviceToCheckin < ActiveRecord::Migration
  def change
    add_column :checkins, :device_id, :integer
    add_index :checkins, :device_id
  end
end
