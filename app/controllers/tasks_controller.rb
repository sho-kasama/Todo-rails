class TasksController < ApplicationController

  before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    # 検索パラメーターのデフォルトのパラメーターキーは :searchではなく、:qになった
    # 検索フォームの入力内容で検索する
    @q = current_user.tasks.ransack(params[:q])
    # 重複を排除
    @tasks = @q.result(distinct: true).page(params[:page])

    if params[:tag_name]
      @tasks = @tasks.tagged_with("#{params[:tag_name]}") # tagged_with("タグ名")で絞り込む
    end


    # 先ほどselfメソッドで定義したクラスメソッドを呼び出すコントローラーを実装する
    # 新しいアクションを作るのではなく「一覧表示のindexアクションに異なるフォーマットでの出力機能を用紙する」と捉える
    respond_to do |format| # format.htmlはHTMLとしてアクセスされた場合(URLに拡張子なしでアクセスされた場合), format.csvはCSVとしてアクセスされた場合(/task.csvというURLでアクセスされた場合)に実行される
      format.html # HTMLフォーマットについてはslimのindex画面が表示されるだけ
      format.csv { send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"} # send_dataメソッドを使ってレスポンスを送り出し、送り出したデータをブラウザからファイルとしてDLできるようにする
    end
  end

  def show
    # params[:id]にはリクエストパラメーター(params)から得られるid,つまりリクエストされたURL "tasks/[タスクのid]の
    # [タスクのid]部分が格納されてます"
  end

  # エラーハンドリングの実装をする
  def create
    @task = current_user.tasks.new(task_params)

    if params[:back].present?
      render :new
      return
    end

    if @task.save
      TaskMailer.creation_email(@task).deliver_now
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else 
      render :new
    end
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def update 
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    # 今回はサーバーサイドでタスクを削除すればいい。
    # HTTPメソッドだとDELETEなので、リクエストは200か204を返す必要がある
    # またDLETEの場合は、処理だけ受け付けて実際の消去をしない場合は202を返すみたいに
    head :no_content
  end

  # 確認画面を表示するアクションを追加する
  # 新規登録画面から送られてきた情報の検証を行い、問題があれば新規登録画面を検証メッセージと共に表示する
  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  def import 
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: "タスクを追加しました"
  end


  private 


    # フォームからリクエストパラメーターとして送られてきた情報が想定どおりであることをチェックし
    # 受け付ける想定であるname(名称)とdescription(詳しい説明)の情報だけを抜き取る役割をしてる
    def task_params 
      params.require(:task).permit(:name, :description, :image, :tag_list)
    end

    def set_task
      @task = current_user.tasks.find(params[:id])
    end
end