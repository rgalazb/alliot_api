Rails.application.routes.draw do
  devise_for :users,
  path: '',
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  resources :requests, only: [:index, :create]
  resources :comments, only: :create
  resources :reactions, only: :create
end
