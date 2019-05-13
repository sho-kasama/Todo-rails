Rails.application.routes.draw do

  # HTTPメソッド getでログインのフォームを表示する
  get '/login', to: 'sessions#new'

  # HTTPメソッド postでフォームから送られてきた情報を元にログインを行う
  post '/login', to: 'sessions#create'

  # HTTPメソッド DELETEでログアウトを行う
  delete '/logout', to: 'sessions#destroy'



  # route.rb でnamespace :adminのなかに定義を記述しているため
  # URLに /admin, ヘルパーメソッド名にadmin_ がつくようになっている。
  namespace :admin do
    resources :users
  end


  # タスクの一覧(index)が表示されるようにする
  root to: 'tasks#index'
  
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
