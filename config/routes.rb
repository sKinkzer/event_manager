Rails.application.routes.draw do
  devise_for :users
  resources :events

  get '/locations/search', to: 'locations#search'

  post '/events/:id/participate', to: 'events#participate', as: :participate_event
  post '/events/:id/maybe', to: 'events#maybe', as: :maybe_event
  post '/events/:id/decline', to: 'events#decline', as: :decline_event

  root to: "events#index"
end
