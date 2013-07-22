require 'grape/rabl'
module Gohike
  class API < Grape::API
    version 'v1', using: :header, vendor: 'code_for_europe'
    format :json

    desc "Pipe out all content"
    get '/content', :format => :text do
      header "Content-Version",$redis.get(:version)
      {:version => $redis.get(:version), :profiles => JSON.parse($redis.get(:profiles))}
    end

    desc "Respond with either OK or UPDATE"
    params do
      optional :version, type: String, desc: "Content version on the device or none"
    end
    post '/ping' do
      if params[:version] && params[:version] == $redis.get(:version)
        {status: :ok}
      else
        {status: :update, size: $redis.get(:size)}
      end
    end

    params do
      requires :checkins, type: Array, desc: "Checkins array"
      requires :identifier, type: String, desc: "Device Identifier"
    end
    post '/checkin' do
      error!('Unauthorized', 401) unless headers['Take-A-Hike-Secret'] == ENV["APP_SECRET"].strip
      device = Device.where(:identifier => params[:identifier]).first_or_create
      params[:checkins].each do |checkin|
        c = Checkin.where(:location_id => checkin[:location_id], :route_id => checkin[:route_id], :device_id => device.id).first_or_create
        c.update_attribute(:stamp, Time.zone.parse(checkin[:timestamp])) unless checkin[:timestamp].nil?
      end
    end

  end
end

