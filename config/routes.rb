Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      match '*path' => 'options_request#preflight', via: :options

      post '/token', to: 'tokens#create', as: :tokens
      get '/load', to: 'users#load', as: :load
      resources :users, only: [:create, :update]
      resources :profiles, only: [:show, :update]
      resources :multi_profiles, only: [:index, :create, :update, :destroy]
      resources :exhibits, only: [:index, :create, :update, :destroy]
      resources :multi_exhibits, only: [:create, :update, :destroy]

      namespace :tourist do
        post '/token', to: 'tokens#create', as: :tokens
        get '/load', to: 'tourists#load', as: :load
        resources :spots, only: [:index, :show]
        resources :tourists, only: [:create, :update]
        resources :reviews, only: [:create, :destroy]
        resources :favorites, only: [:create, :destroy]
        resources :exhibit_favorites, only: [:create, :destroy]
      end
    end
  end
end
