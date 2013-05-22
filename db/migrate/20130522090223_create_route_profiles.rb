class CreateRouteProfiles < ActiveRecord::Migration
  def change
    create_table :route_profiles do |t|
      t.string :name_en
      t.text :description_en
      t.string :name_nl
      t.text :description_nl
      t.string :icon
      t.string :image

      t.timestamps
    end
  end
end
