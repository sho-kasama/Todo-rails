class SampleJob < ApplicationJob
  queue_as :default

  # performメソッドの内部を変更する
  # ここでは処理が行われていることを把握しやすくするためにSidekiqのログにメッセージを表示しています
  def perform(*args)
    Sidekiq::Logging.logger.info "サンプルジョブを実行しました"
  end
end
