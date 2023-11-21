Rails.application.routes.draw do
  
  root 'home#index'

  namespace :api do
    namespace :v1 do
      post '/:id/post_idea', to: 'artist_prompts#create'
    end
  end
end
