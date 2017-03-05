class UsersController < ApplicationController

  load_and_authorize_resource

  def index
    @users = User.all.where("is_super_admin = false AND has_access = true").order(created_at: :desc)
  end

  # TODO test???
  def ban_users
    logger.info("Restricting access to user #{params[:user_id]}")
    begin
      banned_user = User.find(params[:user_id])
      banned_user.has_access = false
      banned_user.save!
      flash[:message] = "User #{banned_user.email} has been banned from AIT Events"
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "The user does not exist."
    rescue
      flash[:error] = "Could not ban user. Please try again later."
    end
    redirect_to action: :index
  end

  def show_banned_users
    @users = User.all.where(has_access: false)
  end

end
