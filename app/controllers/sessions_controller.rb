class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    logger.debug auth.to_yaml
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
    logger.debug "Session created for user #{user.id}"
    session[:user_id] = user.id
    redirect_to request.env['omniauth.origin'] || home_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path, :notice => "Signed out"
  end
end
