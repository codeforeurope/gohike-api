class LocationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /locations
  # GET /locations.json
  def index

    respond_to do |format|
      format.html # index.html.old.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @markers = @location.to_gmaps4rails
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create

    respond_to do |format|
      if @location.save
        format.html {
          if params[:location][:image].present?
            redirect_to crop_location_path(@location), notice: 'Location was successfully created.'
          else
            redirect_to @location, notice: 'Location was successfully created.'
          end
        }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html {
          if params[:location][:image].present?
            redirect_to crop_location_path(@location), notice: 'Location was successfully updated.'
          else
            redirect_to @location, notice: 'Location was successfully updated.'
          end
        }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
end
