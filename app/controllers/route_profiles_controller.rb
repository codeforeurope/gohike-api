class RouteProfilesController < ApplicationController
  # GET /route_profiles
  # GET /route_profiles.json
  def index
    @route_profiles = RouteProfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @route_profiles }
    end
  end

  # GET /route_profiles/1
  # GET /route_profiles/1.json
  def show
    @route_profile = RouteProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @route_profile }
    end
  end

  # GET /route_profiles/new
  # GET /route_profiles/new.json
  def new
    @route_profile = RouteProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @route_profile }
    end
  end

  # GET /route_profiles/1/edit
  def edit
    @route_profile = RouteProfile.find(params[:id])
  end

  # POST /route_profiles
  # POST /route_profiles.json
  def create
    @route_profile = RouteProfile.new(params[:route_profile])

    respond_to do |format|
      if @route_profile.save
        format.html { redirect_to @route_profile, notice: 'Route profile was successfully created.' }
        format.json { render json: @route_profile, status: :created, location: @route_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @route_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /route_profiles/1
  # PUT /route_profiles/1.json
  def update
    @route_profile = RouteProfile.find(params[:id])

    respond_to do |format|
      if @route_profile.update_attributes(params[:route_profile])
        format.html { redirect_to @route_profile, notice: 'Route profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @route_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /route_profiles/1
  # DELETE /route_profiles/1.json
  def destroy
    @route_profile = RouteProfile.find(params[:id])
    @route_profile.destroy

    respond_to do |format|
      format.html { redirect_to route_profiles_url }
      format.json { head :no_content }
    end
  end
end
