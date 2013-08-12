class LocationsController < InheritedResources::Base
  layout Proc.new { |controller| (controller.request.xhr?) ? false : 'application' }
  before_filter :authenticate_user!
  before_filter :load_markers, :only => :show
  optional_belongs_to :city

  load_and_authorize_resource :city, :through => :location
  load_and_authorize_resource :location
  has_scope :in_city

  def load_markers
    @markers = resource.to_gmaps4rails
  end

  # POST /routes
  # POST /routes.json
  def create
    create! do |success, failure|
      success.html {
        if @location.id.blank?
          logger.info @location.errors
          #logger.info @location.errors
        end
        redirect_to params[:location][:image].present? ? crop_location_url(@location) : location_url(@location)
      }
    end
  end

  # PUT /routes/1
  # PUT /routes/1.json
  def update
    update! do |success, failure|
      success.html {
        redirect_to params[:location][:image].present? ? crop_location_url(@location) : location_url(@location)
      }
    end
  end

  def search
    @locations = @locations.where("id NOT IN (:exclude) AND (name ILIKE :term OR description ILIKE :term OR address ILIKE :term)", {:term => "%#{params[:term]}%", :exclude => params[:exclude].split(",")})
  end
end
