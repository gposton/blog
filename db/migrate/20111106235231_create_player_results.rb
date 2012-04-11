class CreatePlayerResults < ActiveRecord::Migration
  def self.up
    create_table :player_results do |t|
      t.integer :user_id
      t.integer :tournament_id
      t.integer :buy_in, :default => 0
      t.integer :winnings, :default => 0
      t.integer :finish, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :player_results
  end
end
