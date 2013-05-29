collection :route_profiles, :object_root => false
attributes :id, :name_en, :name_nl, :description_en, :description_nl, :image_data, :icon_data
child :routes do
  attributes :id, :name_en, :name_nl, :description_en, :description_nl, :image_data, :icon_data
  glue :route_profile do
    attributes :id => :profile_id
  end
  child :waypoints do
    attributes :rank
    glue :location do
      attributes :id => :location_id, :name_en => :name_en, :name_nl => :name_nl, :description_en => :description_en, :description_nl => :description_nl, :latitude => :latitude, :longitude => :longitude, :image_data => :image_data
    end
    glue :route do
      attributes :id => :route_id
    end
  end
end