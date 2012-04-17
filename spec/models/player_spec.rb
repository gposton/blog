require File.dirname(__FILE__) + "/../spec_helper"

describe Player do
  before :each do
    @player = FactoryGirl.create(:player)
  end

  it "belongs to a tournament" do
    @player.tournament.should_not be_nil
  end

  it "is a user" do
    @player.user.should_not be_nil
  end

  it "validates uniqueness of player/tournament as a multicolumn key" do
    player2 = FactoryGirl.build(:player, :user_id => @player.user_id, :tournament_id => @player.tournament_id)
    player2.should_not be_valid
  end

  it "calculates net winnings by subtracting buy_in from winnings" do
    player = FactoryGirl.create(:player, :buy_in => 40, :winnings => 60)
    player.net.should be 20
    player = FactoryGirl.create(:player, :buy_in => 60, :winnings => 40)
    player.net.should be -20
    player = FactoryGirl.create(:player, :buy_in => 40, :winnings => 40)
    player.net.should be 0
  end

  it "determines if the player had a net loss" do
    player = FactoryGirl.create(:player, :buy_in => 40, :winnings => 60)
    player.loss?.should be_false
    player = FactoryGirl.create(:player, :buy_in => 60, :winnings => 40)
    player.loss?.should be_true
    player = FactoryGirl.create(:player, :buy_in => 40, :winnings => 40)
    player.loss?.should be_false
  end
end
