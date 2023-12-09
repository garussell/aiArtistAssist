Rails.application.routes.draw do
  root 'dashboard#index'

  # Artist Resources
  resources :artists do
    resources :artist_files

    member do
      patch 'upload_avatar'
    end
  end

  # Login/Logout
  post "/sessions/login", to: "sessions#login"
  get "/sessions/logout", to: "sessions#logout"


  # AI API Endpoint
  namespace :api do
    namespace :v1 do
      post '/:id/post_idea', to: 'artist_prompts#create'
    end
  end
end
