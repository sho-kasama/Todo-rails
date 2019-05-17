FactoryBot.define do
    factory :task do
        name { 'テストをかく' }
        description { ' RSpec & Capybara & FactoryBotを準備する' }
        user # これは「先ほど定義した :userという名前のFactoryをTaskモデルに定義されたuserという名前の関連を生成するのに利用する」
    end
end