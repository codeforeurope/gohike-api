class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :identifier
      t.string :platform
      t.string :platform_version
      t.string :default_language
      t.references :user

      t.timestamps
    end
    add_index :devices, :user_id
    add_index :devices, :identifier
  end
end
