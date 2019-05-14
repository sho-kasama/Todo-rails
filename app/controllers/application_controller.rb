class ApplicationController < ActionController::Base

    # helper_method指定をすることで全てのビューからも使えるようにしている
    helper_method :current_user



    private 

      # 代入演算子としての|| ( 使い方は左辺が存在しない場合(偽)の場合、右辺の値が代入されるイメージ)
      def current_user
        @current_user ||= User.find_by(id: session(:user_id)) if session[:user_id]
      end
      
end
