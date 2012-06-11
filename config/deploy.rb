require 'mongrel_cluster/recipes'
require 'bundler/capistrano'
require "rvm/capistrano"

set :application, "blog"
set :repository,  "https://github.com/gposton/blog.git"
set :branch, "master"
set :deploy_to, "/var/www/blog"
set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"
set :user, "root"
set :rvm_ruby_string, 'ruby-1.9.3@blog'
set :rvm_install_type, :stable
set :rvm_path, '/usr/local/rvm'
set :bundle_without, [:test, :development]

#set :use_sudo, true
#default_run_options[:pty] = true

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "gbposton.no-ip.org"                          # Your HTTP server, Apache/etc
role :app, "gbposton.no-ip.org"                         # This may be the same as your `Web` server
role :db,  "gbposton.no-ip.org", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "killall ruby"
   run "rm /var/www/blog/shared/pids/*" rescue nil
   run "cd #{release_path} && bundle exec mongrel_rails start -p 8000 -e production -d -l /var/www/blog/shared/log/mongrel.8000.log -p /var/www/blog/shared/pids/mongrel.8000.pid"
   run "cd #{release_path} && bundle exec mongrel_rails start -p 8001 -e production -d -l /var/www/blog/shared/log/mongrel.8001.log -p /var/www/blog/shared/pids/mongrel.8001.pid"
   run "cd #{release_path} && bundle exec mongrel_rails start -p 8002 -e production -d -l /var/www/blog/shared/log/mongrel.8002.log -p /var/www/blog/shared/pids/mongrel.8002.pid"
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
 desc "Update the crontab file"  
 task :update_crontab, :roles => :db do  
   run "cd #{release_path} && bundle exec whenever --update-crontab #{application}"  
 end
end

before 'deploy:setup', 'rvm:install_ruby'
after "deploy:symlink", "deploy:update_crontab"  
after "deploy", "deploy:migrate"
