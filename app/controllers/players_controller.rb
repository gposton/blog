class PlayersController < ApplicationController
  set_tab :poker

  respond_to :html, :json

  def update
    @player = Player.find(params[:id])
    @player.update_attributes(params[:player])
    respond_with @player
  end
end
