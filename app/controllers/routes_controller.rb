class RoutesController < InheritedResources::Base
  before_filter :authenticate_user!
  optional_belongs_to :route_profile
  load_and_authorize_resource :route_profile, :through => :route
  load_and_authorize_resource
  before_filter :load_locations, :only => :show
  before_filter :load_profiles, :except => [:index, :destroy, :show]
  has_scope :in_city

  # POST /routes
  # POST /routes.json
  def create
    create! do |success, failure|
      success.html {
        redirect_to params[:route][:image].present? ? crop_route_url(@route) : route_url(@route)
      }
    end
  end

  # PUT /routes/1
  # PUT /routes/1.json
  def update
    update! do |success, failure|
      success.html {
        redirect_to params[:route][:image].present? ? crop_route_url(@route) : route_url(@route)
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

  def publish
    if @route.validate_for_publishing
      if @route.published_key.blank?
        @route.published_key = Devise.friendly_token
      end
      delete_published_key = @route.published_key
      renderer = Rabl::Renderer.new('route', @route, {:format => 'json', :view_path => 'app/views/api'})
      route_json = renderer.render
      md5 = OpenSSL::Digest::MD5.new
      published_key = md5.hexdigest(route_json)
      route_json.sub! delete_published_key, published_key
      $redis.del delete_published_key if $redis.exists(delete_published_key)
      $redis.set published_key, route_json
      @route.update_attribute :published_key, published_key
      render :partial => "details"
    else

    end


  end

  def unpublish
    $redis.del @route.published_key
    @route.update_attribute :published_key, nil
    render :partial => "details"
  end


  private
  def load_locations
    location_ids = @route.waypoints.map { |waypoint| waypoint.location_id }
    @locations = @route.city.locations.where('id NOT in (?)', location_ids.empty? ? 0 : location_ids)
  end

  def load_profiles
    if @route.city_id.present?
      @profiles = RouteProfile.scoped_by_city_id([@route.city_id])
    else
      @profiles = []
    end
  end
end

