Rails.application.routes.draw do

  get 'assignments/ps3'

  get 'assignments/ps4'

  get 'assignments/ps5'

  get 'assignments/ps3_profile1'
  get 'assignments/ps3_profile2'
  get 'assignments/ps3_profile3'

  get 'users/ban_users'
  get 'users/show_banned_users'

  get 'users/index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get "login" => redirect("auth/google_oauth2"), as: :login

  resources :sessions, only: [:create, :destroy]
  resources :events do
    resources :announcements
    get 'volunteers', to: 'volunteers#index'
    get 'add_volunteer', to: 'volunteers#add_volunteer'
    get 'accept_volunteer/:id', to: 'volunteers#accept_volunteer', as: 'accept_volunteer'
    get 'reject_volunteer/:id', to: 'volunteers#reject_volunteer', as: 'reject_volunteer'
  end

  get 'home/index'
  root to: 'home#index'

  resources :new_ideas, only: [:index, :create, :show] do
    patch :close_idea
    patch :ban_idea
    resources :comments
  end

  resources :committees

end
