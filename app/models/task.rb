class Task < ApplicationRecord
  belongs_to :project
  has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :due_date, presence: true

  # Scopes for status
  scope :active, -> { where(status: ['pending', 'in_progress']) }
  scope :pending, -> { where(status: 'pending') }
  scope :in_progress, -> { where(status: 'in_progress') }
  scope :completed, -> { where(status: 'completed') }

  # Scopes for deadlines
  scope :due_on, ->(date) { where(due_date: date) }
  scope :due_before, ->(date) { where("due_date < ?", date) }
  scope :overdue, -> { active.where("due_date < ?", Date.current) }
end