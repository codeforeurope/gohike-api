class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.references :user
      t.references :authorizable, :polymorphic => true

      t.timestamps
    end
    add_index :roles, [:authorizable_type, :authorizable_id]
  end
end
