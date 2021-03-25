# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 
    if user.supervisor_role?
          can :manage, :all
          can :access, :rails_admin     
          can :manage, :dashboard         
    end
    if user.user_role?
          can :read, :all
    end
  end
end
