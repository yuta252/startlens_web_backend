Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      match '*path' => 'options_request#preflight', via: :options

      post '/token', to: 'tokens#create', as: :tokens
      resources :users, only: [:create, :update]
      resources :profiles, only: [:show, :update]
      resources :multi_profiles, only: [:index, :create, :update, :destroy]
    end
  end
end
