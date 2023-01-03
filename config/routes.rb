Rails.application.routes.draw do
  scope :api do
    resources :users, only: [:show, :create, :update]
    post 'auth/login', to: 'authentication#login'
    get 'user', to: 'users#current'
  end
end
