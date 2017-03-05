class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is_super_admin?
      can :manage, :all

    elsif user.is_master_admin?
      can [:index,:show_banned_users], User
      can [:index, :show, :create], NewIdea
      # TODO
      can [:close_idea, :ban_idea], NewIdea, :committee_id => user.committee.id

      can :manage, Comment
      can [:index, :show, :create], Event
      can [:update, :destroy, :edit], Event, :committee_id => user.committee.id
      can [:create, :edit, :update, :destroy], Announcement, :event => { :committee_id => user.committee.id }
      can [:accept_volunteer, :reject_volunteer], Volunteer, :event => { :committee_id => user.committee.id }
      can [:index], Volunteer

    elsif user.is_member?

      can [:index, :create], NewIdea
      can [:create,:index], Comment
      can [:edit, :update, :destroy], Comment, :user_id => user.id
      can [:add_volunteer], Volunteer
      can [:show, :index], Event

    else
      can :index, HomeController
      can [:show, :index], Event
    end
  end
end
