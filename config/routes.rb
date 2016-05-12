Rails.application.routes.draw do

  namespace :api do
    resources :stops, only: [:index]
    get "/itinerary", to: "itineraries#calculate", as: :calculate_itinerary
  end

  resources :user_trips, only: [:new, :create, :show]

  root to: "user_trips#new"
end
