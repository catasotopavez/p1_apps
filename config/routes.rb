Rails.application.routes.draw do
  get 'friendship_tokens/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      post "graphql", to: "graphql#execute"
      get 'users/:email', to: 'users#show', constraints: { email: /[^\/]+/ }, as: 'show_user_wemail'
      patch 'users/:email', to: 'users#update', constraints: { email: /[^\/]+/ }, as: 'update_user_wemail'
      get 'users/:email/edit', to: 'users#edit', constraints: { email: /[^\/]+/ }, as: 'edit_user_wemail'
      delete 'users/:email', to: 'users#destroy', constraints: { email: /[^\/]+/ }, as: 'destroy_user_wemail'
      post 'users', to: 'users#create', as: 'create_user'
      post 'destinations', to: 'destinations#create'
      get 'trips/:trip_id/trip_destinations', to: 'trip_destinations#index'
      get 'users/avatar/:email', to: 'users#avatar', as: 'user_avatar'
      post '/friendships', to: 'friendships#create'
      get "posts/index_by_user_and_trip", to:"posts#index_by_user_and_trip"
      post 'posts/:id/upload_image', to: "posts#upload_image"
      get "posts/:id/images", to:"posts#images"


      #Pregunta 5
      delete 'posts/:post_id/destinations/:id', to: 'destinations#destroy_post_destination', as: 'destroy_post_destination'


      resources :api_keys, path: 'api-keys', only: %i[index create destroy]

      resources :trips, shallow: true do
        resources :posts, shallow: true
        resources :destinations
        resources :users
      end

      resources :destinations
      resources :posts
      resource :friendship_token, only: [:show], controller: 'friendship_tokens'

    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
