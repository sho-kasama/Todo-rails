class Task < ApplicationRecord


  # メソッド名の前にselfをつけることでクラスメソッドを定義することができる
  # CSVデータにどの属性をどの順番で出力するかをcsv_attributesと言うクラスメソッドから得られるように定義している
  def self.csv_attributes
    ["name","description","created_at","updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|  # CSV.generateを使ってCSVデータの文字列を生成します。生成した文字列がgenerate_csvクラスメソッドの戻り値となる
      csv << csv_attributes # CSVの1行目としてヘッダを出力します。
      all.each do |task|
        csv << csv_attributes.map{|attr| task.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      task = new
      task.attributes = row.to_hash.slice(*csv_attributes)
      task.save!
    end
  end


  # レコードとファイルの間に 1対1のマッピングを設定します。各レコードには1つのファイルを添付します。 
  has_one_attached :image

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
