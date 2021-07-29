# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

server '143.198.75.40', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:pixelhandler/blog-api.git'
set :application,     'blog-api'

## Defaults:
# set :scm,           :git
# set :branch,        :main
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"
append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/secrets.yml.key', 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, 'bin', 'log', 'pids', 'tmp/cache', 'sockets', 'vendor/bundle', 'public/system'

# If using Digital Ocean's Ruby on Rails Marketplace framework, your username is 'rails'
set :user,            'deploy'
set :puma_threads,    [1, 6]
set :puma_workers,    0

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, {
  path: "/home/deploy/.rbenv/plugins/ruby-build/bin:/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:$PATH",
  rbenv_root: "/home/deploy/.rbenv"
}

set :rbenv_type, :user # or :system, or :fullstaq (for Fullstaq Ruby), depends on your rbenv setup
# set :rbenv_ruby, '3.0.1'

# in case you want to set ruby version from the file:
set :rbenv_ruby, File.read('.ruby-version').strip

# def env_vars
#   ". /etc/default/nginx"
# end

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_prefix, "#{env_vars} && RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :rbenv_roles, :all # default value
# set :rbenv_ruby_dir, "/home/deploy/.rbenv/versions/#{fetch(:rbenv_ruby)}" # :~/.rbenv/versions/3.0.1
# set :rbenv_custom_path, '/usr'

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/deploy/www/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/blog_rsa) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before 'deploy:starting', 'puma:make_dirs'
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do

      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc "Check that we can access everything"
  task :check_write_permissions do
    on roles(:all) do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        info "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is not writable on #{host}"
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  before 'deploy:migrate', 'deploy:set_rails_env'

  desc 'Restart application'
    task :restart do
      on roles(:app), in: :sequence, wait: 5 do
        invoke 'puma:restart'
      end
  end

  before :starting,     :check_revision
  before :starting,     :check_write_permissions
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :publishing,   :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma