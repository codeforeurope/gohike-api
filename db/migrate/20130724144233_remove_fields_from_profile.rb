class RemoveFieldsFromProfile < ActiveRecord::Migration
  def up
    remove_column :route_profiles, :description
    remove_column :route_profiles, :description_nl
    remove_column :route_profiles, :name_nl
    remove_column :route_profile_translations, :description
  end
  def down
    add_column :route_profiles, :description, :text
    add_column :route_profiles, :description_nl, :text
    add_column :route_profiles, :name_nl, :string
    add_column :route_profile_translations, :description, :text
  end
end
