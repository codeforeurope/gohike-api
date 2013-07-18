class RoutesController < InheritedResources::Base
  before_filter :authenticate_user!
  optional_belongs_to :route_profile
  load_and_authorize_resource


  # GET /routes/1
  # GET /routes/1.json
  def show
    #@route = @route_profile.routes.find(params[:id])
    location_ids = @route.waypoints.map { |waypoint| waypoint.location_id }
    @locations = Location.where('id NOT in (?)', location_ids.empty? ? 0 : location_ids)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @route }
    end
  end



  # POST /routes
  # POST /routes.json
  def create

    respond_to do |format|
      if @route.save
        format.html {
          if params[:route][:image].present?
            redirect_to crop_route_profile_route_path(@route_profile, @route), notice: 'Route was successfully created.'
          else
            redirect_to route_profile_route_url(@route_profile, @route), notice: 'Route was successfully created.'
          end
         }
        format.json { render json: @route, status: :created, location: @route }
      else
        format.html { render action: "new" }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /routes/1
  # PUT /routes/1.json
  def update

    respond_to do |format|
      if @route.update_attributes(params[:route])
        format.html {
          if params[:route][:image].present?
            redirect_to crop_route_profile_route_path(@route_profile, @route), notice: 'Route was successfully updated.'
          else
            redirect_to route_profile_route_url(@route_profile, @route), notice: 'Route was successfully updated.'
          end
        }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end



  def waypoints
    to_preserve = []
    @route = @route_profile.routes.find(params[:id])
    waypoints = params[:waypoints]
    waypoints.each_with_index do | waypoint, index|
      w = @route.waypoints.where(:location_id => waypoint[:location_id]).first_or_create
      w.rank = index
      w.save
      to_preserve << w.id
    end
    if !to_preserve.empty?
      @route.waypoints.where("id NOT IN (?)", to_preserve).destroy_all
    end
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end




end
