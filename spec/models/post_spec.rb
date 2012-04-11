require File.dirname(__FILE__) + "/../spec_helper"

describe Post do
  it 'validates the presence and uniqueness of title' do
    Factory.build(:post, :title => nil).should_not be_valid
    Factory.create(:post, :title => 'title')
    Factory.build(:post, :title => 'title').should_not be_valid
  end

  it 'validates the presence and uniqueness of web title' do
    Factory.build(:post, :title => '').should_not be_valid
    Factory.create(:post, :title => 'title test')
    Factory.build(:post, :title => 'title_test').should_not be_valid
  end

  it 'creates a web_title by replacing spaces with underscores and removing non-alphanumeric characters' do
    post = Factory.create(:post, :title => 'a title,with/some!odd1characters')
    post.web_title.should == 'a_titlewithsomeodd1characters'
  end

  it 'should use the web title as the id for the url' do
    post = Factory.create(:post, :title => 'title')
    post.to_param.should == 'title'
  end
end
