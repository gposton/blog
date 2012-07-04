class PlayersController < ApplicationController
set_tab :poker

respond_to :html, :json

  def create
    @player = Player.new(params[:player])
    flash[:error] = @player.errors.full_messages.join("\n") unless @player.save
    redirect_to @player.tournament
  end

  def update
    @player = Player.find(params[:id])
    @player.update_attributes(params[:player])
    respond_with @player
  end
end
