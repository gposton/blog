World(ShowMeTheCookies)

Given /^the following posts have been created$/ do |table|
  table.hashes.map do |hash|
    post = Post.create(:title => hash['Title'], :content => hash['Content'])
    tag = Tag.create(:name => hash['Tag'], :posts => [post])
  end
end

When /^.*visits the (.*?) page$/ do |page|
  visit(self.send("#{page.gsub(' ','_')}_path"))
end

When /^a[n]? (.*) logs in with (.*)$/ do |user_type, oauth_provider|
  visit(home_path)
  click_link('Sign out') rescue
  FUNCTIONAL_USERS # Not sure why, but if I take this line out, I randomly get nul values for 'user' in the next step
  user = FUNCTIONAL_USERS[user_type]
  if Capybara.current_driver == Capybara.javascript_driver
    visit 'http://www.google.com'
    # clear google oauth session
    delete_cookie 'GALX'
    delete_cookie 'GAPS'
    delete_cookie 'LSID'
    delete_cookie 'LSOSID'
    expire_cookies

    visit(home_path)
    click_link("auth_#{oauth_provider}")
    step "signs in to google with #{user[:email]} and #{user[:pass]} and allows access"
  else
    visit(home_path)
    OmniAuth.config.add_mock(oauth_provider, {:uid => user[:uid], :info => {:name => user[:name]}})
    click_link("auth_#{oauth_provider}")
  end
  case user_type
  when 'admin'
    User.find_by_name(user[:name]).update_attributes(:poker_player => true, :admin => true)
  when 'user with an email address'
    User.find_by_name(user[:name]).update_attribute(:email, 'me@me.com')
  when 'poker player'
    User.find_by_name(user[:name]).update_attributes(:poker_player => true, :id => 1)
  when 'normal user'
    User.find_by_name(user[:name]).update_attributes(:email => nil)
  end
end

When /^.*signs in to google with (.*) and (.*) and allows access$/ do |email, pass|
  click_link 'change_user_link' rescue # In case another user is already signed in.
  sleep 1

  # Sign in
  begin
    fill_in 'Email', :with => email
    fill_in 'Passwd', :with => pass
    uncheck 'PersistentCookie'
    click_button 'signIn'
  rescue
    # We don't really care about errors because if a user is already signed in
    # this should be skipped.
  end

  # Allow access
  begin
    uncheck 'remember_choices'
    click_button 'approve_button'
  rescue
    # We don't really care about errors because if a user has already allowed access
    # this should be skipped.
  end
end

When /^(?:.*)enters (.*) in the (.*) field$/ do |text, field|
  field = field.gsub(' ', '_')
  fill_in(field, :with => text)
  # This was added to submit the best in place fields and wait for the page to update after entering text/updates
  if find(:xpath, "//form[@class='form_in_place']/input[@name='#{field}']")
    find_field(field).native.send_key(:tab)
    sleep 0.5
  end rescue nil
end

When /^clicks '(.*)'$/ do |button|
 click_button button
end

When /^(?:.*)clicks the element with a (.*) of (.*)/ do |attribute, value|
  find(:xpath, "//span[@#{attribute.strip}='#{value.strip}']").click()
end

When /^picks the (.*) from the calendar$/ do |date|
  date = date.gsub(/[^0-9]/, '') #remove everything except for numbers
  find(:xpath, "//div[text()='#{date}']").click()
end

When /^(?:the user )?follows '(.*)'/ do |link|
 click_link link
end

When /^uploads a photo$/ do
  attach_file('photo_image', File.join(Rails.root, 'public', 'images', 'on_the_rock.jpeg'))
  click_button 'Upload'
end

When /^selects "([^"]*)" from "([^"]*)"$/ do |option, field|
  select(option, :from => field)
end

When /^selects "([^"]*)"$/ do |option|
  select(option)
end

When /^checks '(.*)'$/ do |field|
  check(field)
end

Then /^the user should see '(.*)'$/ do |text|
  page.should have_content text
end

Then /^the user should (not )?see '(.*)' in the row for user (.*)$/ do |present, text, user|
  present = present.nil?
  xpath = "//tr[@id='result_#{user}']"
  if present
    page.find(:xpath, xpath).should have_content text
  else
    page.find(:xpath, xpath).should_not have_content text
  end
end

Then /^the user should not see '(.*)'$/ do |text|
  page.should_not have_content text
end

Then /^the user should not see a link named '(.*)'$/ do |link|
  page.should_not have_link link
end

Then /^the user should see a link named '(.*)'$/ do |link|
  find_link(link).visible?.should == true
end

Then /^the user should be on the (.*?) page(?: with id, (.*))?$/ do |page, id|
  current_path.should == self.send("#{page}_path", id)
end

Then /^the '(.*)' button should be disabled$/ do |id|
  page.should_not have_xpath "//input[@id='#{id}' and @disabled]"
end

Then /^the user should see the photo(?: in (.*))?$/ do |album_name|
  xpath = album_name ? "//div[@id='#{album_name}']/spam/img[@alt='On_the_rock']" : "//img[@alt='On_the_rock']"
  page.should have_xpath "//img[@alt='On_the_rock']"
end

Then /^the user should not see the photo$/ do
  xpath = "//img[@alt='On_the_rock']"
  page.should_not have_xpath xpath
end
