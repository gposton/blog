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
