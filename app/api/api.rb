require 'grape/rabl'
module Gohike
  class API < Grape::API
    version 'v1', using: :header, vendor: 'code_for_europe'
    format :json

    desc "Pipe out all content"
    get '/content', :format => :text do
      {:profiles => JSON.parse($redis.get(:profiles)), :version => $redis.get(:version)}
      #'{"profiles":' + $redis.get(:profiles) + ', "version":"' + $redis.get(:version) +'" }'
    end

    desc "Respond with either OK or UPDATE"
    params do
      optional :version, type: String, desc: "Content version on the device or none"
    end
    post '/ping' do
      if params[:version] && params[:version] == $redis.get(:version)
        {status: :ok}
      else
        {status: :update}
      end
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

