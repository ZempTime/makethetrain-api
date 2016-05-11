set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '107.170.18.147', user: 'deploy', roles: %w{web app}
