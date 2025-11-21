class Task < ApplicationRecord
  belongs_to :project

  has_many :notifications

  validates :title, presence: true
  validates :due_date, presence: true
end
