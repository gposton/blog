class PlayerResultToPlayer < ActiveRecord::Migration
  def up
    create_table :players do |t|
      t.integer :user_id
      t.integer :tournament_id
      t.integer :buy_in, :default => BUY_IN
      t.integer :winnings, :default => 0
      t.integer :finish, :default => 0

      t.timestamps
    end

    PlayerResult.all.each do |player|
      Player.create(player.attributes)
    end
  end

  def down
    drop_table :players
  end
end
