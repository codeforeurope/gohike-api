require 'grape/rabl'
module Gohike
  class APIv2 < Grape::API
    version 'v2', using: :header, vendor: 'code_for_europe'
    format :json
    formatter :json, Grape::Formatter::Rabl

    desc "Called upon app start, returns :within, and :other lists of cities"
    params do
      requires :latitude, type: Numeric, desc: "latitude and longitude of the device"
      requires :longitude, type: Numeric, desc: "latitude and longitude of the device"
    end
    post '/locate', :rabl => "locate" do

      @within = City.by_device_location(params[:latitude], params[:longitude])
      @other = City.all

    end

    desc "Called once every 24 hours by the device to get available routes and profiles"
    params do
      requires :city_id, type: Integer, desc: "City id"
    end
    get '/catalog/:city_id', :rabl => "catalog" do

      @profiles = City.find(params[:city_id]).publishable_profiles

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

