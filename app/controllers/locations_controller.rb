class LocationsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :load_markers, :only => :show
  load_and_authorize_resource
  has_scope :in_city

  def load_markers
    @markers = resource.to_gmaps4rails
  end

  # POST /routes
  # POST /routes.json
  def create
    create! {
      params[:route_profile][:image].present? ? crop_location_url(@location) : location_url
    }

  end

  # PUT /routes/1
  # PUT /routes/1.json
  def update
    update! {
      params[:route_profile][:image].present? ? crop_location_url(@location) : location_url
    }
  end

  #protected
  #def collection
  #  city_id = params[:in_city] || (cities_curated.first.id if !cities_curated.empty?)
  #
  #  end_of_association_chain.in_city(city_id)
  #end
end
