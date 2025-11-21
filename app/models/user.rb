class User < ApplicationRecord
  has_many :notifications
  has_many :tasks, through: :projects
  has_many :projects

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email_address, presence: true, uniqueness: true
end
