class RouteProfilesController < InheritedResources::Base

  before_filter :authenticate_user!
  load_and_authorize_resource :city, :through => :route_profile
  load_and_authorize_resource :route_profile

  #defaults :singleton => true
  optional_belongs_to :city
  has_scope :in_city

  before_filter :load_routes, :only => :show

  def index
    super
  end

  def in_cities
    @profiles = RouteProfile.scoped_by_city_id(params[:city_ids])
    render :partial => "routes/profile"

  end

  # POST /route_profiles
  # POST /route_profiles.json
  def create
    create! {
      params[:route_profile][:image].present? ? crop_route_profile_url(@route_profile) : route_profile_url(@route_profile)
    }
  end


# PUT /route_profiles/1
# PUT /route_profiles/1.json
  def update
    update! {
      params[:route_profile][:image].present? ? crop_route_profile_url(@route_profile) : route_profile_url(@route_profile)
    }
  end

  private
  def load_routes
    @routes = @route_profile.routes
  end

end
