Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    post 'auth' => 'auth#authenticate'
    post 'commenter' => 'auth#authenticate_commenter'

    namespace :v1 do
      #jsonapi_resources :users, only: [:show, :index]
      jsonapi_resources :authors, only: [:create, :show, :index, :update, :destroy]
      jsonapi_resources :posts, only: [:create, :show, :index, :update, :destroy]
      jsonapi_resources :comments, only: [:create, :show, :index, :update, :destroy]
      jsonapi_resources :tags, only: [:create, :show, :index, :update, :destroy]
      root to: 'api#index'
    end
  end
end
