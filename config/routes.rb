Rails.application.routes.draw do

  # タスクの一覧(index)が表示されるようにする
  root to: 'tasks#index'
  
  
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
