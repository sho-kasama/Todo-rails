class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  

  # executeで実行される『DELETE FROM tasks;』というSQLによって,今まで作られたタスクが全て削除される
  # 既存のタスクがある状態でタスクとユーザーの関連を表す(user_id)を追加するとNOT NULL 制約に引っかかっる
  def up
    execute 'DELETE FROM tasks;'
    add_reference :tasks, :user, null: false, index: true
  end


  def down
    remove_reference :tasks, :user, index: true
  end


end
