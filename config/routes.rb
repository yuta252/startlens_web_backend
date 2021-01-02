Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post '/token', to: 'tokens#create', as: :tokens
      resources :users, only: [:create, :update]
      resources :profiles, only: [:show, :update]
    end
  end
end
