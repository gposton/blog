class AddGameNumberToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :game_number, :integer, :default => 1
  end
end
