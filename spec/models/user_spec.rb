require File.dirname(__FILE__) + "/../spec_helper"

describe User do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  it 'gets a list of all tournaments won' do
    @user.tournaments_won.count.should be 0
    @user.poker_results << FactoryGirl.create(:player, :finish => 2)
    @user.tournaments_won.count.should be 0
    @user.poker_results << FactoryGirl.create(:player, :finish => 1)
    @user.tournaments_won.count.should be 1
  end

  it 'total the winnings/losses from all tournaments' do
   @user.net_winnings.should be 0
   @user.poker_results << FactoryGirl.create(:player, :buy_in => 20, :winnings => 40)
   @user.net_winnings.should be 20
   @user.poker_results << FactoryGirl.create(:player, :buy_in => 20, :winnings => 0)
   @user.net_winnings.should be 0
   @user.poker_results << FactoryGirl.create(:player, :buy_in => 20, :winnings => 0)
   @user.net_winnings.should be -20
  end
end
