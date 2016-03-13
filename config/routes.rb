Rails.application.routes.draw do

  resources :stops, only: [:index]
  get "/itinerary", to: "itineraries#calculate", as: :calculate_itinerary
  root to: "home#index"
end
