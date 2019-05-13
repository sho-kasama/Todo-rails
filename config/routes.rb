Rails.application.routes.draw do

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
