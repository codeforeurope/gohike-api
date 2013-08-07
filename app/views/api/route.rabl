object :route
attributes :id

node(:image) do |route|
  {:md5 => route.image_mobile_md5, :url => route.image.mobile.url}
end
node(:icon) do |route|
  {:md5 => route.image_icon_md5, :url => route.image.icon.url}
end

extends "translation", :locals => {:node => :name}

extends "translation", :locals => {:node => :description}



child :waypoints do
  attributes :rank
  glue :location do
    attributes :id => :location_id, :latitude => :latitude, :longitude => :longitude
    node(:image) do |wp|
      {:md5 => wp.image_mobile_md5, :url => wp.image.mobile.url}
    end
    extends "translation", :locals => {:node => :name}

    extends "translation", :locals => {:node => :description}

  end
  glue :route do
    attributes :id => :route_id
  end
end