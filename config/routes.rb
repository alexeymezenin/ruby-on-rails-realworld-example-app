Rails.application.routes.draw do
  scope :api do
    post 'auth/login', to: 'authentication#login'
    resources :users, only: [:show, :create]
    put 'user', to: 'users#custom_update'
    get 'user', to: 'users#current'

    scope :profiles do
      get ':username', to: 'profiles#show'
      post ':username/follow', to: 'profiles#follow'
      delete ':username/follow', to: 'profiles#unfollow'
    end
  end
end
