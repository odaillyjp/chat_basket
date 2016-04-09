class ApplicationJob < ActiveJob::Base
  after_perform do
    # NOTE: アダプタを何も設定していない場合にコネクションが途切れない問題があるので、手動でクローズする
    ActiveRecord::Base.connection.close if Rails.env.development?
  end
end
