source 'http://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql'

# my gems
gem 'paperclip'
gem 'acts_as_commentable'
gem 'haml'
gem 'omniauth-openid'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'RedCloth'
gem 'paperclip'
gem 'tabs_on_rails'
gem 'whenever'
# We need to use mongrel so that omniauth works correctly
# https://github.com/intridea/omniauth/issues/43
#gem 'mongrel'
#gem 'dispatcher'
#gem 'mongrel_cluster', :git => 'https://github.com/kyusik/mongrel_cluster.git'
gem 'unicorn'

# Install reference: http://stackoverflow.com/questions/3979495/using-calendar-date-select-with-rails-3
gem 'googlecharts'
gem 'newrelic_rpm'
gem 'encryptor'
gem 'best_in_place', :git => 'https://github.com/bernat/best_in_place.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  #gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
  gem 'guard-ctags-bundler'
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem 'sqlite3'
end

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'ruby-debug19'
  # Was getting a warning when running spork, require false to fix
  # http://datacodescotch.blogspot.com/2011/11/warning-cucumber-rails-required-outside.html
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'database_cleaner'
  gem 'spork'
  gem 'launchy'
  gem 'autotest-rails'
  gem 'autotest-growl'
  gem 'show_me_the_cookies'
end
