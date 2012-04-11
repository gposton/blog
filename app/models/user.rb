class User < ActiveRecord::Base
  has_many :photos
  has_many :poker_results, :foreign_key => 'user_id', :class_name => 'Player'

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name']
      user.email = auth['info']['email']
    end
  end

  def tournaments_won
    self.poker_results.reject{|result|result.finish != 1}
  end

  def net_winnings
    total_buy_ins = self.poker_results.collect{|result|result.buy_in}.inject(:+)
    total_buy_ins = 0 if total_buy_ins.nil?
    total_winnings = self.poker_results.collect{|result|result.winnings}.inject(:+)
    total_winnings = 0 if total_winnings.nil?
    total_winnings - total_buy_ins
  end
end

