class SessionsController < ApplicationController

  # 親クラスにログインされてないとログイン画面にリダイレクトされてしまうフィルタが実装されているので
  # ログインの処理のコントローラーにフィルタをスキップさせるコードをかく

  skip_before_action :login_required

  def new
  end

  # authenticateメソッドはUserクラスに has_secure_passwordを記述した時に自動で追加された、認証のためのメソッドです
  # 引数で受け取ったパスワードをハッシュ化してその結果がUserオブジェクト内部に保存されているdigestと一致するかどうかを調べます
  # メアドに対応するユーザーデータが見つからない時は、userはnilになりますので authenticateメソッドを呼び出す部分ではぼっち演算子を使います
  # 認証が成功した場合にセッションにuser_idを格納しています

def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password]) # &.はメソッドを呼び出されたオブジェクトがnilでない場合はその結果をnilだった場合はnilを返す
      session[:user_id] = user.id 
      redirect_to root_path, notice: 'ログインしました'
    else 
      render　:new
    end
end


def destroy
  reset_session
  redirect_to root_path, notice: 'ログアウトしました'
end


private 

  def session_params
    params.require(:session).permit(:email, :password)
  end


end