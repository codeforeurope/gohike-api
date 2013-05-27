class RoutesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_profile
  #authorize_resource
  # GET /routes
  # GET /routes.json
  def index
    @routes = @route_profile.routes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @routes }
    end
  end

  # GET /routes/1
  # GET /routes/1.json
  def show
    @route = @route_profile.routes.find(params[:id])
    location_ids = @route.waypoints.map { |waypoint| waypoint.location_id }
    @locations = Location.where('id NOT in (?)', location_ids.empty? ? 0 : location_ids)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @route }
    end
  end

  # GET /routes/new
  # GET /routes/new.json
  def new
    @route = @route_profile.routes.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @route }
    end
  end

  # GET /routes/1/edit
  def edit
    @route = @route_profile.routes.find(params[:id])
  end

  # POST /routes
  # POST /routes.json
  def create
    @route = @route_profile.routes.new(params[:route])

    respond_to do |format|
      if @route.save
        format.html { redirect_to route_profile_route_url(@route_profile, @route), notice: 'Route was successfully created.' }
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
    @route = @route_profile.routes.find(params[:id])

    respond_to do |format|
      if @route.update_attributes(params[:route])
        format.html { redirect_to route_profile_route_url(@route_profile, @route), notice: 'Route was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route = @route_profile.routes.find(params[:id])
    @route.destroy

    respond_to do |format|
      format.html { redirect_to route_profile_route_url(@route_profile, @route) }
      format.json { head :no_content }
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

  private
  def load_profile
    @route_profile = RouteProfile.find(params[:route_profile_id])
  end


end
