Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/post_idea', to: 'artist_prompts#create'
    end
  end
end
