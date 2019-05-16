FacotoryBot.define do
    facotry :user do
        name { 'テストユーザー' }
        email { 'test@example.com' }
        password { 'password' }
    end
end

# ここではfacotryというメソッドを利用して、:userという名前のUserクラスのファクトリを定義しています
# クラスを:userという名前から自動で読み込んでくれてる。ファクトリ名とクラス名が異なる場合には、:classオプションでクラスを指定することができる