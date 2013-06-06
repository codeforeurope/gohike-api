class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string :name_en
      t.string :name_nl
      t.text :description_en
      t.text :description_nl
      t.string :image
      t.string :rewardable_type
      t.integer :rewardable_id

      t.timestamps
    end
  end
end
