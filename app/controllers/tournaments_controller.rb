class TournamentsController < ApplicationController
  set_tab :poker

  before_filter :authenticated?
  before_filter :authorize, :only => :new

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new params[:tournament]
    if @tournament.save
      Notifier.deliver_new_tournament(@tournament, Tournament.recent_tournaments)
      redirect_to edit_tournament_path @tournament
    else
      render :action => 'new'
    end
  end

  def update
    @tournament = Tournament.find_by_name params[:id]
    @tournament.attributes = params[:tournament]
    if @tournament.save
      redirect_to @tournament.state.closed? ? @tournament : (edit_tournament_path @tournament)
    else
      render :action => 'edit'
    end
  end

  def edit
    @tournament = Tournament.find_by_name params[:id]
  end

  def show
    @tournament = Tournament.find_by_name params[:id]
  end

  def index
    @tournaments = current_user.poker_player? ? Tournament.all : []
  end
end
