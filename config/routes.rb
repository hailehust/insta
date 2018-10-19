Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
             controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }

  # get '/users/:id', to: 'users#show'
  # /users/3 -> Users controller, show action, params {id: '3'}
  # route for showing one user's profile
  resources :users, only: [:show]

  # routes for posts: index/ show/ create/ destroy (delete)
  resources :posts, only: [:index, :show, :create, :destroy] do
    resources :photos, only: [:create]  #nested resources => co post id truoc photo id
    resources :likes, only: [:create, :destroy, :index, :show, :new, :edit, :update], shallow: true
  end
end
