class ApplicationController < ActionController::Base

    # helper_method指定をすることで全てのビューからも使えるようにしている
    helper_method :current_user

    # フィルタ(Filter) という機能を使う
    # フィルタはモデルのコールバックのところで説明したのと似た概念でアクションを処理する前後で任意の処理を挟むことができる
    before_action :login_required


    private 

      # 代入演算子としての|| ( 使い方は左辺が存在しない場合(偽)の場合、右辺の値が代入されるイメージ)
      def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      end

      # これでアプリケーション内の全てのアクションの処理前にユーザーがログイン済みかどうかのチェックが入り、ログイン済みでなかった場合はログイン画面を表示するようになります
      # 今の場合だとログイン画面を表示するためのアクションに対しても login_requiredフィルタが実行されてしまため、アプリケーションのどのURLを押してもredirectする
      # これを避けるために Session_controllerはログインしてなくとも利用できるようにする

      def login_required
        redirect_to login_path unless current_user
      end

      
end
