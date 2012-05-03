class UsersController < ApplicationController
  set_tab :poker

  before_filter :authenticated?
  before_filter :me?

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    @user.attributes = params[:user]
    puts @user.email
    if @user.save
      flash[:notice] = "You'll #{@user.poker_player? ? 'now' : 'no longer'} receive poker updates at #{current_user(true).email}."
      redirect_to tournaments_path
    else
      Notifier.error('Could not change poker registration status', current_user).deliver
      logger.error("Could not change poker registration status for #{current_user}")
      flash[:error] = "Sorry, I could not change your registration status."
      redirect_to tournaments_path
    end
  end

  def toggle_poker_player
    @user = User.find params[:id]
    @user.poker_player = !@user.poker_player?
    if @user.save
      flash[:notice] = "You'll #{@user.poker_player? ? 'now' : 'no longer'} receive poker updates at #{current_user.email}."
      redirect_to tournaments_path
    else
      Notifier.error('Could not change poker registration status', current_user).deliver
      logger.error("Could not change poker registration status for #{current_user}")
      flash[:error] = "Sorry, I could not change your registration status."
      redirect_to tournaments_path
    end
  end
end
