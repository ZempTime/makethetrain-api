Rails.application.routes.draw do

  get "/path", to: "paths#reveal", as: :reveal_path

  root to: "home#index"
end
