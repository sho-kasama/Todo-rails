class TaskMailer < ApplicationMailer
    default from: 'todo@example.com'



    def creation_email(task)
      @task = task
      mail(
        subject: 'タスク作成完了メール',
        to: 'user@example.com',
        from: 'todo@example.com'
      )
     end
end
