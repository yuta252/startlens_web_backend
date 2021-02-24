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
      resources :dashboards, only: [:index]
      get '/test', to: 'tests#index', as: :tests

      namespace :tourist do
        post '/token', to: 'tokens#create', as: :tokens
        get '/load', to: 'tourists#load', as: :load
        resources :spots, only: [:index, :show]
        resources :tourists, only: [:create, :update]
        resources :reviews, only: [:create, :destroy]
        resources :favorites, only: [:index, :create, :destroy]
        resources :exhibit_favorites, only: [:create, :destroy]
        resources :user_statistics, onley: [:create]
      end
    end
  end
end
