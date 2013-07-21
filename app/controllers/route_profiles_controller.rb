class RouteProfilesController < InheritedResources::Base

  before_filter :authenticate_user!
  load_and_authorize_resource :route
  #has_scope :in_cities do |controller, scope, value|
  #  scope.in_cities(value.split(","))
  #end

  def in_cities
    @profiles = RouteProfile.scoped_by_city_id(params[:city_ids])
    render :partial => "routes/profile"

  end

  # POST /route_profiles
  # POST /route_profiles.json
  def create
    create! {
      params[:route_profile][:image].present? ? crop_route_profile_url(@route_profile) : route_profiles_url
    }
  end


# PUT /route_profiles/1
# PUT /route_profiles/1.json
  def update
    update! {
      params[:route_profile][:image].present? ? crop_route_profile_url(@route_profile) : route_profiles_url
    }
  end


end
