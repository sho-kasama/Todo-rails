Rails.application.routes.draw do

  controller :root do 
    get :about
    get :rules
    get :privacy
    get :contact
  end


  controller :tasks do
    root 'tasks#index' 
    resources :tasks do
      post :confirm, action: :confirm_new, on: :new 
      post :import, on: :collection
    end
  end


  namespace :admin do
    resources :users
  end


  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  resources :contacts, only: %i(new create)

end
