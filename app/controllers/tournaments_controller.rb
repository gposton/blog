class TournamentsController < ApplicationController
  set_tab :poker

  before_filter :authenticated?
  before_filter :authorize, :only => [:new, :create]

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new params[:tournament]
    if @tournament.save
      Notifier.new_tournament(@tournament, Tournament.last_weeks_games, poker_players.collect{|player| player.email}).deliver
      redirect_to edit_tournament_path @tournament
    else
      render :action => 'new'
    end
  end

  def update
    @tournament = Tournament.find_by_param params[:id]
    @tournament.attributes = params[:tournament]
    if @tournament.save
      redirect_to @tournament.state.closed? ? @tournament : (edit_tournament_path @tournament)
    else
      render :action => 'edit'
    end
  end

  def edit
    @tournament = Tournament.find_by_param params[:id]
  end

  def show
    @tournament = Tournament.includes(:players).find_by_param params[:id]
  end

  def index
    @tournaments = current_user.poker_player? ? Tournament.includes(:players, :state).all : []
  end
end
