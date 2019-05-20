class UsersController < ApplicationController
  
  # コントローラーが使うレイアウトを宣言している
  layout 'users', only: %i[new create]


  def new
    @user = User.new

  end

  # ユーザーのidの読み出しにはparamsを使った
  # findメソッドでは自動的に整数型に変換される
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
   if @user.save
   else
    render :new
   end
  end
end
