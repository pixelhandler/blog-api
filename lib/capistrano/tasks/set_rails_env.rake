namespace :deploy do
  task :set_rails_env do
    puts "[deploy:set_rails_env] `set :rails_env, #{fetch(:rails_env)}`"
    set :rails_env, (fetch(:rails_env) || fetch(:stage))
  end
end

Capistrano::DSL.stages.each do |stage|
  after stage, 'deploy:set_rails_env'
end
