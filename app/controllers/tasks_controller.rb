class TasksController < ApplicationController
  
  # タスク一覧を作成日時の新しい順に表示する
  def index
    @tasks = currnet_user.tasks.order(created_at: :desc)
  end

  def show
    # params[:id]にはリクエストパラメーター(params)から得られるid,つまりリクエストされたURL "tasks/[タスクのid]の
    # [タスクのid]部分が格納されてます"
    @task = Task.find(params[:id])
  end

  # エラーハンドリングの実装をする
  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else 
      render :new
    end
  end

  def new
    @task = Task.new
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update 
    task = current_user.tasks.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to tasks_url,notice: "タスク「#{task.name}」を削除しました。"
  end




  private 


    # フォームからリクエストパラメーターとして送られてきた情報が想定どおりであることをチェックし
    # 受け付ける想定であるname(名称)とdescription(詳しい説明)の情報だけを抜き取る役割をしてる
    def task_params 
      params.require(:task).permit(:name, :description)
    end



end
