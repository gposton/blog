require File.dirname(__FILE__) + "/../spec_helper"

describe Post do
  it 'validates the presence and uniqueness of title' do
    FactoryGirl.build(:post, :title => nil).should_not be_valid
    FactoryGirl.create(:post, :title => 'title')
    FactoryGirl.build(:post, :title => 'title').should_not be_valid
  end

  it 'creates a web_title by replacing spaces with underscores and removing non-alphanumeric characters' do
    post = Post.create(:title => 'a title,with/some!odd1characters')
    post.web_title.should == 'a_titlewithsomeodd1characters'
  end

  it 'ensure that the created web_title is unique' do
    Post.create(:title => 'title')
    post = Post.create(:title => 'title*')
    post.web_title = 'title_1'
    post = Post.create(:title => 'title/')
    post.web_title = 'title_2'
  end

  it 'should use the web title as the id for the url' do
    post = FactoryGirl.create(:post, :title => 'title')
    post.to_param.should == 'title'
  end
end
