class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
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
