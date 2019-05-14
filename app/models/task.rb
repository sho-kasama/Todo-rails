class Task < ApplicationRecord

    # 検証前の正規化
    before_validation :set_nameless_name



    validates :name, presence: true, length: { maximum: 30 }
    # オリジナルな検証コードをかく
    validate :validate_name_not_including_comma




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
