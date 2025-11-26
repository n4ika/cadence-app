class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :user_id, presence: true
  validates :task_id, presence: true

  # Helpers
  def read?
    read_at.present?
  end

  def unread?
    read_at.nil?
  end

  # Scopes
  scope :unread, -> { where(read_at: nil) }
  scope :recent, ->(limit = 5) { order(created_at: :desc).limit(limit) }

  # Instance method
  def mark_as_read!
    update(read_at: Time.current)
  end
end
