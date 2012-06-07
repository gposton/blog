require File.dirname(__FILE__) + "/../spec_helper"

describe TournamentsController do

  it 'should send an email to all poker players when a new tournament is created' do
    player1 = FactoryGirl.create(:user, :poker_player => true, :email => 'test1@test.com')
    player2 = FactoryGirl.create(:user, :poker_player => true, :email => 'test2@test.com')
    # This user is not a poker player, so he should not get an email
    FactoryGirl.create(:user, :poker_player => false, :email => 'test3@test.com')

    @controller.stub!(:current_user).and_return FactoryGirl.create(:user, :admin => true)
    mail = mock(Object)

    Notifier.should_receive(:new_tournament).with(anything(), anything(), [player1.email, player2.email]).and_return(mail)
    mail.should_receive(:deliver)

    post :create, :tournament => {:date => '01/01/2011'}
  end

end
