Rails.application.routes.draw do
  root 'dashboard#index'

  # Artist Resources
  resources :artists do
    resources :artist_files do
      member do
        get 'previous_artist_file'
        get 'next_artist_file'
      end
    end

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
