class SessionsController < ApplicationController

  skip_before_action :require_login

  def create
    begin
      user = User.from_omniauth(request.env["omniauth.auth"])
      if(!user.has_access)
        flash[:error] = "You have been revoked access to this page"
        redirect_to root_path
        return
      end
      session[:user_id] = user.id
      if(user.is_member)
        redirect_to new_ideas_path
      elsif user.is_master_admin
        redirect_to committee_path(user.committee)
      else
        redirect_to users_index_path
      end
      rescue
      flash[:error] = "Error occured while logging you in"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:message] = "Successfully logged out"
    redirect_to root_path
  end

  def oauth_failure
    flash[:error] = "Please login using your AIT email"
    redirect_to root_path
  end
end
