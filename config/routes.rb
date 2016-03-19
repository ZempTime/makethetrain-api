Rails.application.routes.draw do

  namespace :api do
    resources :stops, only: [:index]
    get "/itinerary", to: "itineraries#calculate", as: :calculate_itinerary
  end

  resource :transit, only: [:new, :create, :show]

  root to: "transits#new"
end
