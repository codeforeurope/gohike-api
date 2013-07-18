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
      can :manage, RouteProfile
      cannot [:create, :update, :destroy], RouteProfile do |profile|
        !user.role? :curator, profile.city
      end
      can :manage, Route
      cannot [:create, :update, :destroy], Route do |route|
        !user.role? :curator, route.profile.city
      end
      can :manage, Location
      cannot [:create, :update, :destroy], Location do |location|
        !user.role? :curator, location.city
      end
      #this would probably only be used in controller
      can :manage, Reward
      cannot [:create, :update, :destroy], Reward do |reward|
        !user.role? :curator, reward.route.profile.city
      end
    else
      can :read, Location
    end
    cannot [:create, :update, :destroy], Checkin
    can [:read], Reward

  end
end
