class Message < ApplicationRecord
  belongs_to :user
  validates :content, presence: true

  after_commit :enqueue_message_job

  private

  def enqueue_message_job
    MessageRelayJob.perform_later(self)
  end
end
