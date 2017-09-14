class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    # user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      # can :manage, :educator
    elsif(user.educator?)
      # can :read, :all
      can :create,Course
      can :update,Course, :user_id => user.id
      can :destroy,Course, :user_id => user.id
      
      can :read,Course do |course|
        course.user_id == user.id
        # puts "index",course.user_id,user.id,course.user_id!=user.id
        # false
      end
      
      can :manage,Quiz, :course => { :user_id => user.id }
      
      can :manage,Enrolled
      can :update,Educator,:user_id => user.id
      
      
    elsif user.student?
      cannot :manage,Course
      can :read, [Course]
      cannot :manage,Educator
      cannot :manage,Student
      can :update,Student,:user_id => user.id
      
      can :read,Quiz,:status_type =>"active"
      can :update,Enrolled,:status_type do |enrolled|
        enrolled.student_id == Student.find_by_user_id(user.id).id
      end
      # can :manage, Enrolled
      # can :update,Enrolled,:student_id => Student.where(user_id:user.id).first
      
      # cann
    
    else
      # can :read, :all
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
