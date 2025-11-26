class Task < ApplicationRecord
  belongs_to :project

  has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :due_date, presence: true
end
