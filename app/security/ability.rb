  class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.role? :global_admin
      can :manage, :all
    elsif user.roles.count > 0
      can :manage, City
      cannot [:create, :update, :destroy], City do |city|
        !user.role? :curator, city
      end
      can [:read, :new, :search], RouteProfile
      can [:create, :update, :destroy, :crop], RouteProfile do |profile|
        user.role? :curator, profile.city
      end
      can [:read, :new, :search, :waypoints], Route
      can [:create, :update, :destroy, :crop, :publish, :unpublish], Route do |route|
        user.role? :curator, route.city
      end
      can [:read, :new, :search], Location
      can [:create, :update, :destroy, :crop], Location do |location|
        user.role? :curator, location.network
      end
      #can :manage, Reward

      can [:new,:create, :update, :destroy], Reward do |reward|
        user.role? :curator, reward.route.city
      end

    else
      can :read, Location
    end
    cannot [:create, :update, :destroy], Checkin
    can :read, Reward
    can :read, Route
  end
end
