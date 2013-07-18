class RouteProfilesController < InheritedResources::Base
  before_filter :authenticate_user!
  load_and_authorize_resource


  # POST /route_profiles
  # POST /route_profiles.json
  def create

    respond_to do |format|
      if @route_profile.save
        format.html {
          if params[:route_profile][:image].present?
            redirect_to crop_route_profile_url(@route_profile), notice: 'Route profile was successfully created.'
          else
            redirect_to route_profile_routes_url(@route_profile), notice: 'Route profile was successfully created.'
          end
        }
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

    respond_to do |format|
      if @route_profile.update_attributes(params[:route_profile])
        format.html {
          if params[:route_profile][:image].present?
            redirect_to crop_route_profile_url(@route_profile), notice: 'Route profile was successfully updated.'
          else
            redirect_to route_profile_routes_url(@route_profile), notice: 'Route profile was successfully updated.'
          end
        }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @route_profile.errors, status: :unprocessable_entity }
      end
    end
  end


end
