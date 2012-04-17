require File.dirname(__FILE__) + "/../spec_helper"

describe Tag do
  it 'validates the presence and uniqueness of name' do
    Tag.new(:name => nil).should_not be_valid
    FactoryGirl.create(:tag, :name => 'tag')
    FactoryGirl.build(:tag, :name => 'tag').should_not be_valid
  end
end
