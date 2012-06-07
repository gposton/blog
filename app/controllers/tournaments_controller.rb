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
      redirect_to tournament_path @tournament
    else
      puts @tournament.errors
    end
  end

  def show
    @tournament = Tournament.includes(:players).find_by_param params[:id]
  end

  def index
    @tournaments = current_user.poker_player? ? Tournament.includes(:players).all : []
  end

  def rsvp
    tournament = Tournament.find_by_param params[:id]
    player = Player.find_or_initialize_by_user_id_and_tournament_id(current_user.id, tournament.id)
    player.no_show = params[:no_show]
    unless player.save
      flash[:error] = 'Sorry, there was an error and we could not add you to the tournament.'
      logger.error = "Could not add user (#{current_user}) to tournament (#{tournament})"
    end
    redirect_to tournament
  end
end
