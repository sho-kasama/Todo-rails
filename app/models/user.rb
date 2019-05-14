class User < ApplicationRecord

    # has_secure_passwordを記述するとデータベースのカラムには対応しない属性が2つ追加されました
    # 1つ目はpasswordです。　　二つ目は password_confirmation
    # パスワードのハッシュ化だけでなく、認証のための機能も追加してくれてる。
    # モデルにhas_secure_passwordを追加するとどんなメソッドが追加されるのかを調べる
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true


    # User と taskの関係は一対多なので次のように記述する
    has_many :tasks

end
