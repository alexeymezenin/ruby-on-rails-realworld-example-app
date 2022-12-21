Rails.application.routes.draw do
  scope :api do
    resources :users, only: [:show, :create, :update]
    post 'users/login', to: 'users#login'
  end
end
