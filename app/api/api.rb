class API < Grape::API

  version 'v1', using: :header, vendor: 'twitter'
  format :json

end
