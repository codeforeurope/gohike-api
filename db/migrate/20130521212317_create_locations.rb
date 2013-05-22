class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name_en
      t.text :description_en
      t.string :name_nl
      t.text :description_nl
      t.decimal :latitude, :precision => 12, :scale => 9
      t.decimal :longitude, :precision => 12, :scale => 9
      t.string :address
      t.string :city
      t.string :postal_code

      t.timestamps
    end
  end
end
