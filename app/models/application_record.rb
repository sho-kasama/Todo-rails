class ApplicationRecord < ActiveRecord::Base

  # 対応するデータベースのデータベースのテーブルを用意しない場合に書く必要がある。
  # ActiveRecord::Baseを継承したクラスを作成し、さらにそのクラスを継承させたい場合に
  # self.abstaract_classを記述する
  self.abstract_class = true
end
