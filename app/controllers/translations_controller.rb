class TranslationsController < ApplicationController
  def new

    @form_source = []

    resource_type = params[:resource_type].constantize

    @resource = params[:resource_id] == 0.to_s ? resource_type.new : resource_type.find(params[:resource_id])

    ### this is here because resources :routes is not in routes.rb.
    #if resource_type == Route
    #  @parent_resource = @resource.route_profile
    #  @form_source << @parent_resource
    #end
    ###
    @form_source << @resource
    @locale = params[:target_locale]

    respond_to do |format|
      format.html { render :layout => "ajax" }
      format.json { render json: @resource }
    end
  end
end
