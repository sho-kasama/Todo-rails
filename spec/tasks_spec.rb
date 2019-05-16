


require 'rails_helper'



describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      # ユーザーAを作成しておく
      # 作成者がユーザーAであるタスクを作成しておく
    end
    
    context 'ユーザーAがログインしている時' do
      before do
        # ユーザーAがログインする
      end


      it 'ユーザーAが作成したタスクが表示される' do
        # 作成済みのタスクの名称が画面上に表示されていることを確認
      end
    end
  end
end