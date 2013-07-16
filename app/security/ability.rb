class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.role? :global_admin
      can :manage, :all
    elsif user.roles.count > 0
      #can [:read, :update], City do |city|
      #  user.role? :curator, city
      #end
      can :manage, RouteProfile do |profile|
        user.role? :curator, profile.city
      end
      can :manage, Route do |route|
        user.role? :curator, route.profile.city
      end
      can [:read, :index], Location do |location|
        user.roles.count > 0
      end
      can :manage, Location do |location|
        user.role? :curator, location.city
      end
      #this would probably only be used in controller
      can :manage, Reward do |reward|
        user.role? :curator, reward.route.profile.city
      end
    else
      can :read, Location
    end
    cannot [:create, :update, :destroy], Checkin
    can [:read], Reward

  end
end
