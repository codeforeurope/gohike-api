require 'grape/rabl'
module Gohike
  class API < Grape::API
    version 'v1', using: :header, vendor: 'code_for_europe'
    format :json
    formatter :json, Grape::Formatter::Rabl

    desc "Pipe out all content"
    get '/content', :rabl => "content" do
      #current_version = params[:current_version]
      @route_profiles = RouteProfile.all(:include =>:routes)
    end

  end
end

