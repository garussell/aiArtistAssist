Rails.application.routes.draw do
  root 'dashboard#index'

  # Artist Resources
  resources :artists

  # Login/Logout
  # get "/artists/login", to: "artists#login"
  post "/artists/login", to: "sessions#new"
  get "/artists/logout", to: "sessions#logout"


  # AI API Endpoint
  namespace :api do
    namespace :v1 do
      post '/:id/post_idea', to: 'artist_prompts#create'
    end
  end
end
