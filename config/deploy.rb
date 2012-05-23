set :user, "vlewin"
set :application, "timetrack"
set :domain, "stealth.suse.de"

set :deploy_to, "/srv/www/htdocs/#{application}"
set :repository, "git://github.com/vlewin/timetrack.git"

#task :beta do
#  set :domain,    "beta.example.com"
#  set :deploy_to, "/path/to/install-beta"
#end

#task :dev do
#  set :domain,    "dev.example.com"
#  set :deploy_to, "/path/to/install-dev"
#end

#task :prod do
#  set :domain,    "example.com"
#  set :deploy_to, "/path/to/install"
#end

namespace :vlad do
  desc "Symlinks the configuration files"
  remote_task :symlink_config, :roles => :web do
    %w(application.yml database.yml).each do |file|
      run "ln -s #{shared_path}/config/#{file} #{current_path}/config/#{file}"
    end
  end

  desc "Full deployment cycle: Update, migrate, restart, cleanup"
  remote_task :deploy, :roles => :app do
    Rake::Task['vlad:update'].invoke
    Rake::Task['vlad:symlink_config'].invoke
    Rake::Task['vlad:migrate'].invoke
    Rake::Task['vlad:start_app'].invoke
    Rake::Task['vlad:cleanup'].invoke
  end
end
