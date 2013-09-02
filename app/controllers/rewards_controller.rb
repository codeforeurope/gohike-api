class RewardsController < InheritedResources::Base
  layout Proc.new { |controller| (controller.request.xhr? || controller.remotipart_submitted?) ? false : 'application' }
  respond_to :js, :json, :html
  before_filter :authenticate_user!, :except => :show
  defaults :singleton => true

  optional_belongs_to :route
  #optional_belongs_to :route_profile

  #load_and_authorize_resource :route_profile, :through => :route
  load_and_authorize_resource :route, :through => :reward
  load_and_authorize_resource :reward

  def build_resource
    super
  end


  def resource
    if params[:id].blank?
      @reward ||= association_chain[0].reward
    else
      @reward = Reward.find(params[:id])
    end
  end

  def edit
    super
  end

  def show
    super do |format|
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

  def destroy
    resource.destroy
    respond_to do |format|
      format.html { head :ok }
      format.json { head :no_content }
    end
  end
end
