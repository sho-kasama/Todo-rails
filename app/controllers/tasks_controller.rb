class TasksController < ApplicationController

  before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    # 検索パラメーターのデフォルトのパラメーターキーは :searchではなく、:qになった

    # 検索フォームの入力内容で検索する
    @q = current_user.tasks.ransack(params[:q])

    # 重複を排除
    @tasks = @q.result(distinct: true)

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
    redirect_to tasks_url,notice: "タスク「#{@task.name}」を削除しました。"
  end

  # 確認画面を表示するアクションを追加する
  # 新規登録画面から送られてきた情報の検証を行い、問題があれば新規登録画面を検証メッセージと共に表示する
  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end




  private 


    # フォームからリクエストパラメーターとして送られてきた情報が想定どおりであることをチェックし
    # 受け付ける想定であるname(名称)とdescription(詳しい説明)の情報だけを抜き取る役割をしてる
    def task_params 
      params.require(:task).permit(:name, :description, :image)
    end

    def set_task
      @task = current_user.tasks.find(params[:id])
    end


end
