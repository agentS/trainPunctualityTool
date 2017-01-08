# config valid only for current version of Capistrano
lock "3.7.1"

server "www.churchwood.at", :primary => true, :roles => %w{web app db}

set :application, "trainPunctualityTool"
set :repo_url, "https://github.com/agentS/trainPunctualityTool.git"
set :scm, :git

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/usr/local/www/trainPunctualityTool"

# Set the user used for the deployment process
set :user, "lukas"
set :use_sudo, false

# Set the rails environment.
set :rails_env, "production"

set :deploy_via, :copy

set :ssh_options, { :forward_agent => true, :port => 2233 }

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/usr/bin/:$PATH" }

set :keep_releases, 2

#Rake::Task["deploy:compile_assets"].clear

namespace :deploy do
  remote_host = "lukas@www.churchwood.at"

  desc "Create a link to the database configuration file."
  task :symlink_db_configuration do
    on remote_host do
      execute "ln -s #{deploy_to}/shared/config/database.yml #{current_path}/config/database.yml"
    end
  end

  desc "Restart passenger"
  task :restart do
    on remote_host do
      execute "touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
    end
  end

  desc "Compile assets."
  task :compile_assets do
    invoke "deploy:assets:precompile_local"
  end

  namespace :assets do
    desc "Precompile assets locally and sync them to the web server"
    task :precompile_local do
      run_locally do
        execute "RAILS_ENV=#{fetch(:stage)} bundle exec rake assets:precompile"
      end

      local_dir = "./public/assets"
      on remote_host do
        remote_dir = "#{remote_host}:#{release_path}/public/assets/"

        run_locally { execute "scp -P 2233 -r #{local_dir} #{remote_dir}" }
      end

      # clean up
      run_locally { execute "rm -rf #{local_dir}" }
    end
  end
end

after "deploy", "deploy:symlink_db_configuration"
after "deploy", "deploy:compile_assets"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"