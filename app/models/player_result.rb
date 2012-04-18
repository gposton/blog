# This class has been depricated.  However it needs to remain in place for future migrations.
# Use player.rb instead
# see db/migrate/20111223075224_player_result_to_player.rb

class PlayerResult < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament

  def net
    self.winnings - self.buy_in
  end

  def loss?
    net < 0
  end

end
