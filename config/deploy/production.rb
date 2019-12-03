set :stage, :production
set :rails_env, :production
set :deploy_to, "/var/www/mobileshop_server"
set :branch, :config_deploy
set :puma_env, fetch(:rack_env, fetch(:rails_env, "production"))
server "ec2-18-218-131-50.us-east-2.compute.amazonaws.com", user: "dodat", roles: %w(web app db)
