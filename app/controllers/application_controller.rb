class ApplicationController < ActionController::Base

    # helper_method指定をすることで全てのビューからも使えるようにしている
    helper_method :current_user



    private 

      def current_user
        @current_user ||= User.find_by(id: session(:user_id)) if session[:user_id]
      end
      
end
