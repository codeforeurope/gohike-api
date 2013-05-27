require 'grape/rabl'
module Gohike
  class API < Grape::API
    version 'v1', using: :header, vendor: 'code_for_europe'
    format :json
    formatter :json, Grape::Formatter::Rabl

    desc "Pipe out all content"
    get '/content' do
      JSON.parse($redis.get('content'))
    end

    get '/ping/:version' do

    end

    get '/progress' do

    end

    params do
      requires :checkins, type: Array, desc: "Checkins array"
    end
    post '/checkin' do
      checkins = params[:checkins]
      checkins.each do |checkin|
        c = Checkin.where(:location_id => checkin[:location_id], :route_id => checkin[:route_id]).first_or_create
        c.update_attribute(:stamp, Time.zone.parse(checkin[:timestamp])) unless checkin[:timestamp].nil?
      end
    end

  end
end

