class RoutesController < InheritedResources::Base
  before_filter :authenticate_user!
  optional_belongs_to :route_profile
  load_and_authorize_resource :route_profile, :through => :route
  load_and_authorize_resource
  before_filter :load_locations, :only => :show
  before_filter :load_profiles, :only => [:new, :edit]
  has_scope :in_city

  # POST /routes
  # POST /routes.json
  def create
    create! do |success, failure|
      success.html {
        if params[:route][:image].present?
          redirect_to crop_route_url(@route)
        else
          redirect_to route_url(@route)
        end
      }
    end

  end

  # PUT /routes/1
  # PUT /routes/1.json
  def update
    update! do |success, failure|
      success.html {
        if params[:route][:image].present?
          redirect_to crop_route_url(@route)
        else
          redirect_to route_url(@route)
        end
      }
    end
  end


  def waypoints
    to_preserve = []
    params[:waypoints].each_with_index do |waypoint, index|
      w = @route.waypoints.where(:location_id => waypoint[:location_id]).first_or_create :rank => index
      to_preserve << w.id
    end
    @route.waypoints.where("id NOT IN (?)", to_preserve).destroy_all unless to_preserve.empty?
    head :no_content
  end


  private
  def load_locations
    location_ids = @route.waypoints.map { |waypoint| waypoint.location_id }
    @locations = Location.where('id NOT in (?)', location_ids.empty? ? 0 : location_ids)
  end

  def load_profiles
    @profiles = RouteProfile.scoped_by_city_id([@route.city_id])
  end
end

