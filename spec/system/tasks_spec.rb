require 'rails_helper'


describe 'タスク管理機能', type: :system do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーz', email: 'z@exmaple.com') }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーv', email: 'v@example.com') }
    let(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a ) }

    
    before do
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
      # Specでは同じ階層にある全てのdescribe/context内で共通する処理は上の階層のbeforeのなかに処理を
      # 書くことで共通化できる
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログインする'
    end    

    # RSpecではitを共通化する方法として、shared_examplesという仕組みを用意してる。
    # exampleとは、itなどの期待する挙動を示す部分のことです
    # このexampleをいくつかまとめて名前をつけて、テストケース間でシェアできるというものです

    shared_examples_for 'ユーザーAが作成したタスクが表示される' do
      it { expect(page).to have_content '最初のタスク' } 
    end



    # 詳細表示機能のSpexを追加する
    describe '一覧表示機能' do
      context 'ユーザーAがログインしている時' do
        let (:login_user) { user_a }

        # shared_exmaplesを利用するという記述
        it_behaves_like 'ユーザーAが作成したタスクが表示される'
      end

      context 'ユーザーBがログインしているとき' do
        let (:login_user) { user_b }

        it 'ユーザーAが作成したタスクが表示されない' do 
          # ユーザーAが作成したタスクの名称が画面上に表示されないことを確認
          expect(page).to have_no_content '最初のタスク'
        end
      end
   end


   # 詳細表示機能のSpecを追加する
   describe '詳細表示機能' do
     context 'ユーザーAがログインしてる時' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end

  # タスクの名称を入力すると登録できることと
  # タスクの名称を入力していないと検証エラーになることの2つのテストケースを記述する


  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in 'Name', with: task_name
      click_button 'Create Task'
    end


    context '新規作成画面で名称を入力したとき' do
      let(:task_name)  { '新規作成のテストを書く' }

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    #context '新規作成画面で名称を入力しなかったとき' do
     # let(:task_name) { '' }

      #it 'エラーとなる' do
      #  within '#error_explanation' do
       #   expect(page).to have_content 'Descriptionを入力してください'
        #end
      #end
    #end
  end
end