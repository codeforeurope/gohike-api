require "rabl"

class HomeController < ApplicationController
  def index
  end

  def publish
    renderer = Rabl::Renderer.new('content', RouteProfile.all(:include => :routes), {:format => 'json', :view_path => 'app/views/api'})
    profiles = renderer.render
    md5 = OpenSSL::Digest::MD5.new
    version = md5.hexdigest(profiles)
    $redis.del :profiles, :version
    $redis.set(:profiles, profiles)
    $redis.set(:version, version)

    render :json => {version:version, length:profiles.length}
  end
end
