Rails.application.routes.draw do
  root 'dashboard#index'

  # Artist Resources
  resources :artists do
    resources :artist_files, only: [:index, :new, :create, :show, :destroy]
  end

  # Login/Logout
  # get "/artists/login", to: "artists#login"
  post "/sessions/login", to: "sessions#login"
  get "/sessions/logout", to: "sessions#logout"


  # AI API Endpoint
  namespace :api do
    namespace :v1 do
      post '/:id/post_idea', to: 'artist_prompts#create'
    end
  end
end
