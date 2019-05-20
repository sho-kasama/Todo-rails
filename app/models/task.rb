class Task < ApplicationRecord

  # %wは配列を作る、配列の要素のスペース区切りで指定する ( 式の展開はされない )
  # ransaclable_attributesには検索対象にすることを許可するカラムを指定する、デフォルトでは全てのカラムを対象としている。
  # 指定されなかったカラムがransackに渡されても無視されるようになります。
  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  
  # ransackable_associationsは検索条件に含める関連を指定できる
  # このメソッドをからの配列を返すようにオーバーライドすることで、検索条件に意図しない関連を含め内容にすることができます
  def self.ransackable_associations(auth_object = nil)
    []
  end



    # 検証前の正規化
    before_validation :set_nameless_name
    validates :name, presence: true, length: { maximum: 30 }

    # オリジナルな検証コードをかく
    validate :validate_name_not_including_comma

    # そのクラス(ここではTask)がある別のクラス(ここではUser)に従属しており、従属先のクラスのidを外部キーとして抱えていることを表しています。
    # いわば親分を指定するようなイメージ
    # このような定義をすることでUserクラスのインスタンスに対して、user.tasksといったメソッドで紐づいたTaskオブジェクトの一覧を得られるようになります
    # またTaskクラスのインスタンスに対しては、task.userで紐づいたUserオブジェクトを得られるようになります
    belongs_to :user

    scope :recent, -> { order(created_at: :desc )}



    private 
     
      # &. ぼっち演算子を使って、nameがnilの場合には例外が発生するのを避けるために &.を利用して,nameがnilの時にはこの検証(errors.addをしない)ようにしている
      def validate_name_not_including_comma
        errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
      end

      # コールバックの実装 三項演算子
      def set_nameless_name
        self.name = '名前なし' if name.blank?
      end


end
