Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  get '/address_search', to: 'home#address_search'
  get '/weather_for_location', to: 'home#weather_for_location', as: 'weather_for_location'
  get '/weather_for_zipcode', to: 'home#weather_for_zipcode', as: 'weather_for_zipcode'
end
