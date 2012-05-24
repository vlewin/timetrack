set :application, "timetrack"
set :repository,  "git://github.com/vlewin/timetrack.git"
set :scm, :git
set :deploy_to, "/srv/www/htdocs/#{application}"

set :user, "vlewin"
set :use_sudo, false

set :branch, "capistrano"
set :scm_verbose, true

set :deploy_via, :remote_cache
set :git_enable_submodules, 1
set :migrate_target, :current

ssh_options[:forward_agent] = true
set :normalize_asset_timestamps, false

default_run_options[:pty] = true

server "stealth.suse.de", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do
  end

  task :stop do
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  namespace :assets do
    task :precompile, :role => :app do
      run "cd #{release_path}/ && rake assets:precompile"
    end
  end

  after "deploy:finalize_update", "deploy:migrate", "deploy:assets:precompile"
end
