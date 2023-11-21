Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/logout'
  
  # root 'home#index'

  # Login/Logout
  get "/artists/login", to: "artists#login"
  post "/artists/login", to: "sessions#new"
  get "/artists/logout", to: "sessions#logout"

  # Artist Resources
  resources :artists, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # AI API Endpoint
  namespace :api do
    namespace :v1 do
      post '/:id/post_idea', to: 'artist_prompts#create'
    end
  end
end
