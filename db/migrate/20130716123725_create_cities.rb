class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.float :radius
      t.string :country_code
      t.string :state_province

      t.timestamps
    end
  end
end
