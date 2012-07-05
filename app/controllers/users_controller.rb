class UsersController < ApplicationController
  set_tab :poker

  layout 'tournaments'

  before_filter :authenticated?
  before_filter :me?

  def show
    @user = User.includes(:poker_results).find params[:id]
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    @user.attributes = params[:user]
    if @user.save
      redirect_to tournaments_path, :notice => "You'll #{@user.poker_player? ? 'now' : 'no longer'} receive poker updates at #{current_user(true).email}."
    else
      Notifier.error('Could not change poker registration status', current_user).deliver
      logger.error("Could not change poker registration status for #{current_user}")
      redirect_to(tournaments_path, :alert => "Sorry, I could not change your registration status.")
    end
  end

  def toggle_poker_player
    @user = User.find params[:id]
    @user.poker_player = !@user.poker_player?
    if @user.save
      redirect_to tournaments_path, :notice => "You'll #{@user.poker_player? ? 'now' : 'no longer'} receive poker updates at #{current_user.email}."
    else
      Notifier.error('Could not change poker registration status', current_user).deliver
      logger.error("Could not change poker registration status for #{current_user}")
      redirect_to(tournaments_path, :alert => "Sorry, I could not change your registration status.")
    end
  end
end
