class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.is_admin?
      #can :discount, :offer
      can :manage, :all
    else

    end
  end
end
