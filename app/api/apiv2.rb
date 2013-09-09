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
      @other = City.with_publishable_profiles
    end

    desc "Called once every 24 hours by the device to get available routes and profiles"
    params do
      requires :city_id, type: Integer, desc: "City id"
      optional :locale, type: String, desc: "Locale"
    end
    get '(:locale/)catalog/:city_id', :rabl => "catalog" do
      I18n.locale = params[:locale].present? ? params[:locale] : :en
      @profiles = City.find(params[:city_id]).publishable_profiles
    end

    desc "This replaces /content endpoint. Provides a direct download of the entire route"
    params do
      requires :route_id, type: Integer, desc: ""
    end
    get '/route/:route_id' do
      JSON.parse($redis.get Route.find(params[:route_id]).published_key)
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

    params do
      requires :user_name, type: String, desc: "User name"
      requires :user_email, type: String, desc: "User email"
      requires :fb_id, type: String, desc: "FB id"
      requires :fb_token, type: String, desc: "FB token"
      requires :fb_expires_at, type:Integer, desc: "FB token expiration date"
      requires :device_id, type: String, desc: "Device UUID or equivalent"
      requires :device_platform, type: String, desc: "Device platform"
      requires :device_version, type: String, desc: "Device platform version"
    end
    post '/connect' do
      error!('Unauthorized', 401) unless headers['Take-A-Hike-Secret'] == ENV["APP_SECRET"].strip

      u = User.where(:email => params[:user_email]).first_or_initialize


      device = u.devices.where(:identifier => params[:device_id]).first_or_initialize
      device.platform = params[:device_platform]
      device.platform_version = params[:device_version]
      login = u.logins.where(:uid => params[:fb_id], :provider => :facebook ).first_or_initialize
      login.token = params[:fb_token]
      login.expires_at = params[:fb_expires_at]
      if(login.new_record?)
        u.logins << login
      end
      u.save!

    end

  end
end

