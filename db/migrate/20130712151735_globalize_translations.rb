class GlobalizeTranslations < ActiveRecord::Migration
  def up
    rename_column :locations, :name_en, :name
    rename_column :locations, :description_en, :description
    Location.create_translation_table!({:name => :string, :description => :text}, {migrate_data: true})

    rename_column :rewards, :name_en, :name
    rename_column :rewards, :description_en, :description
    Reward.create_translation_table!({:name => :string, :description => :text}, {migrate_data: true})

    rename_column :routes, :name_en, :name
    rename_column :routes, :description_en, :description
    Route.create_translation_table!({:name => :string, :description => :text}, {migrate_data: true})

    rename_column :route_profiles, :name_en, :name
    rename_column :route_profiles, :description_en, :description
    RouteProfile.create_translation_table!({:name => :string}, {migrate_data: true})
  end

  def down
    rename_column :locations, :name, :name_en
    rename_column :locations, :description, :description_en
    Location.drop_translation_table!

    rename_column :rewards, :name, :name_en
    rename_column :rewards, :description, :description_en
    Reward.drop_translation_table!

    rename_column :routes, :name, :name_en
    rename_column :routes, :description, :description_en
    Route.drop_translation_table!

    rename_column :route_profiles, :name, :name_en
    rename_column :route_profiles, :description, :description_en
    RouteProfile.drop_translation_table!
  end
end
