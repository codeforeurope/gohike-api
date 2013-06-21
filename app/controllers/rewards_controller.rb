class RewardsController < ApplicationController
  before_filter :authenticate_user!, :except => :show

  layout Proc.new { |controller| (controller.request.xhr? || controller.remotipart_submitted?) ? false : 'application' }
  # GET /rewards
  # GET /rewards.json
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rewards }
    end
  end

  # GET /rewards/1
  # GET /rewards/1.json
  def show
    if params[:route_id].blank?
      @reward = Reward.find(params[:id])
    else
      @route_profile = RouteProfile.find(params[:route_profile_id])
      @route = @route_profile.routes.find(params[:route_id])
      @reward = @route.reward
    end

    respond_to do |format|
      format.html {
        if request.xhr?
          render :partial => 'routes/reward'
        else
          render layout: "reward"
        end


      } # show.html.erb
      format.json { render json: @reward }
    end
  end

  # GET /rewards/new
  # GET /rewards/new.json
  def new
    if params[:route_id].blank?
      @reward = Reward.new
    else
      @route_profile = RouteProfile.find(params[:route_profile_id])
      @route = @route_profile.routes.find(params[:route_id])
      @reward = @route.build_reward
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reward }
    end
  end

  # GET /rewards/1/edit
  def edit
    if params[:route_id].blank?
      @reward = Reward.find(params[:id])
    else
      @route_profile = RouteProfile.find(params[:route_profile_id])
      @route = @route_profile.routes.find(params[:route_id])
      @reward = @route.reward
    end
  end

  # POST /rewards
  # POST /rewards.json
  def create
    if params[:route_id].blank?
      @reward = Reward.new(params[:reward])
    else
      @route_profile = RouteProfile.find(params[:route_profile_id])
      @route = @route_profile.routes.find(params[:route_id])
      @reward = @route.build_reward params[:reward]

    end
    respond_to do |format|
      if @reward.save
        format.html { head :created }
        format.js {}
        format.json { render json: @reward, status: :created, location: @reward }
      else
        format.html { render action: "new", :status => 400 }
        format.js {}
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rewards/1
  # PUT /rewards/1.json
  def update
    if params[:route_id].blank?
      @reward = Reward.find(params[:id])
    else
      @route = Route.find(params[:route_id])
      @reward = @route.reward
    end
    respond_to do |format|
      if @reward.update_attributes(params[:reward])
        format.html { head :ok }
        format.js {}
        format.json { head :no_content }
      else
        format.html { render action: "edit", :status => 400 }
        format.js {}
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rewards/1
  # DELETE /rewards/1.json
  def destroy
    if params[:route_id].blank?
      @reward = Reward.find(params[:id])
    else
      @route_profile = RouteProfile.find(params[:route_profile_id])
      @route = @route_profile.routes.find(params[:route_id])
      @reward = @route.reward
    end
    @reward.destroy

    respond_to do |format|
      format.html { head :ok }
      format.json { head :no_content }
    end
  end
end
