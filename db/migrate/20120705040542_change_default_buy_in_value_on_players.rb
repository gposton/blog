class ChangeDefaultBuyInValueOnPlayers < ActiveRecord::Migration
  def up
    change_column_default(:players, :buy_in, 0)
  end

  def down
  end
end
