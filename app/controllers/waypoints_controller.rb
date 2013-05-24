class WaypointsController < ApplicationController
  before_filter :load_route
  # GET /waypoints
  # GET /waypoints.json
  def index
    @waypoints = @route.waypoints

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @waypoints }
    end
  end

  # GET /waypoints/1
  # GET /waypoints/1.json
  def show
    @waypoint = Waypoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @waypoint }
    end
  end

  # GET /waypoints/new
  # GET /waypoints/new.json
  def new
    @waypoint = Waypoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @waypoint }
    end
  end

  # GET /waypoints/1/edit
  def edit
    @waypoint = Waypoint.find(params[:id])
  end

  # POST /waypoints
  # POST /waypoints.json
  def create
    @waypoint = Waypoint.new(params[:waypoint])

    respond_to do |format|
      if @waypoint.save
        format.html { redirect_to @waypoint, notice: 'Waypoint was successfully created.' }
        format.json { render json: @waypoint, status: :created, location: @waypoint }
      else
        format.html { render action: "new" }
        format.json { render json: @waypoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /waypoints/1
  # PUT /waypoints/1.json
  def update
    @waypoint = Waypoint.find(params[:id])

    respond_to do |format|
      if @waypoint.update_attributes(params[:waypoint])
        format.html { redirect_to @waypoint, notice: 'Waypoint was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @waypoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /waypoints/1
  # DELETE /waypoints/1.json
  def destroy
    @waypoint = Waypoint.find(params[:id])
    @waypoint.destroy

    respond_to do |format|
      format.html { redirect_to waypoints_url }
      format.json { head :no_content }
    end
  end

  private
  def load_route
    @route = Route.find(params[:route_id])
  end

end
