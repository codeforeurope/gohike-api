require 'test_helper'

class RouteProfilesControllerTest < ActionController::TestCase
  setup do
    @route_profile = route_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:route_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create route_profile" do
    assert_difference('RouteProfile.count') do
      post :create, route_profile: { description_en: @route_profile.description_en, description_nl: @route_profile.description_nl, icon: @route_profile.icon, image: @route_profile.image, name_en: @route_profile.name_en, name_nl: @route_profile.name_nl }
    end

    assert_redirected_to route_profile_path(assigns(:route_profile))
  end

  test "should show route_profile" do
    get :show, id: @route_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @route_profile
    assert_response :success
  end

  test "should update route_profile" do
    put :update, id: @route_profile, route_profile: { description_en: @route_profile.description_en, description_nl: @route_profile.description_nl, icon: @route_profile.icon, image: @route_profile.image, name_en: @route_profile.name_en, name_nl: @route_profile.name_nl }
    assert_redirected_to route_profile_path(assigns(:route_profile))
  end

  test "should destroy route_profile" do
    assert_difference('RouteProfile.count', -1) do
      delete :destroy, id: @route_profile
    end

    assert_redirected_to route_profiles_path
  end
end
