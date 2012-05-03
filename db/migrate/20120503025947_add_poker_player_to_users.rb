class AddPokerPlayerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :poker_player, :boolean, :default => false
  end
end
