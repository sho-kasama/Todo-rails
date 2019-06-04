Rails.application.routes.draw do

  # HTTPメソッド getでログインのフォームを表示する
  # GETメソッドで, '/login' というURLに対してリクエストがきたら
  # SessionsControllerのnewというアクションを呼び出して欲しい
  # また、'/login'というURLを,login_pathというヘルパーメソッドで生成できるようにする  
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
  
  # 確認画面は「CRUD」のためのアクションとしては見なされていないため、resoucesで一括で作られるルーティングとは別に定義してやる必要がある
  # そこで保存前の(new)の確認をするという意味を込めて tasks/new/confirmというURLを confirm_newアクションに対応づけることにする
  # routing に collectionを追加するとき 
  # 今回ならPOSTリクエスト+/tasks/import　などの(idを伴なわない)パスを認識し、リクエストをtasksコントローラーのimportアクションに移動させる

  resources :tasks do
    post :confirm, action: :confirm_new, on: :new 
    post :import, on: :collection
  end


end
