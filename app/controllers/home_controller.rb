require "rabl"

class HomeController < ApplicationController
  def index
  end

  def publish
    renderer = Rabl::Renderer.new('content', RouteProfile.all(:include => :routes), {:format => 'json', :view_path => 'app/views/api'})
    json = renderer.render
    md5 = OpenSSL::Digest::MD5.new
    version = md5.hexdigest(json)
    content = '{"profiles":' + json + ', "version": "' + version + '"}'
    $redis.set('content', content)
    render :json => {version:version, length:content.length}
  end
end
