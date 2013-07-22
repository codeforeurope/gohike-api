
require 'apiv1'
require 'apiv2'
module Gohike
  class API < Grape::API
    mount Gohike::APIv1
    mount Gohike::APIv2

  end
end

