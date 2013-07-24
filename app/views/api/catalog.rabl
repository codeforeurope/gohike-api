object false
collection @profiles
attributes :id, :name
node(:image) do |profile|
  {:md5 => profile.image_icon_md5, :url => profile.image.icon.url}
end
child :published_routes => :routes do
  attributes :id, :name, :description
  node(:image) do |route|
    {:md5 => route.image_mobile_md5, :url => route.image.mobile.url}
  end
  node(:icon) do |route|
    {:md5 => route.image_icon_md5, :url => route.image.icon.url}
  end

  glue :route_profile do
    attributes :id => :profile_id
  end

end