Rails.application.routes.draw do
  resources :tags
  resources :articles
  scope :api do
    post 'auth/login', to: 'authentication#login'
    resources :users, only: [:show, :create]
    put 'user', to: 'users#custom_update'
    get 'user', to: 'users#current'

    get 'articles/feed', to: 'articles#feed'
    post 'articles/:slug/favorite', to: 'articles#favorite'
    delete 'articles/:slug/favorite', to: 'articles#unfavorite'
    resources :articles, param: :slug

    scope :profiles do
      get ':username', to: 'profiles#show'
      post ':username/follow', to: 'profiles#follow'
      delete ':username/follow', to: 'profiles#unfollow'
    end

    resources :tags, only: :index
  end
end
