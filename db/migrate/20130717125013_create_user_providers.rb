class CreateUserProviders < ActiveRecord::Migration
  def change
    create_table :user_providers do |t|
      t.references :user
      t.string :provider
      t.string :uid
      t.string :token
      t.integer :expires_at, :default => 0
      t.timestamps
    end
    add_index :user_providers, :user_id
    add_index :user_providers, :uid
    add_index :user_providers, [:provider,:user_id]
  end
end
