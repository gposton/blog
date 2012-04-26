# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticated?
    unless current_user
      flash[:error] = "You'll need to sign in first."
      redirect_to request.referer ? request.referer : home_path
      false
    end
  end

  def authorize
    unless current_user && current_user.admin?
      flash[:error] = "You need to be an admin to do that!"
      redirect_to (request.referer ? request.referer : home_path)
      false
    end
  end

  def special_access?
    unless current_user && current_user.special_access?
      logger.info "#{current_user.name} blocked because the user did not have special access."
      flash[:error] = "You need special access to do that!"
      return false
    end
    true
  end

  def me?
    if current_user.id == params[:id].to_i || current_user.admin?
      return true
    else
      flash[:error] = "You can't look at someone elses stuff."
      redirect_to current_user
      return false
    end
  end
end
