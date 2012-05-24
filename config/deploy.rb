set :application, "timetrack"
set :domain, "stealth.suse.de"
set :user, 'vlewin'
set :use_sudo, false

set :scm, :git
set :repository,  "git@github.com:vlewin/timetrack.git"
set :branch, "capistrano"
set :scm_verbose, true

set :deploy_to, "/srv/www/htdocs/#{application}"

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
