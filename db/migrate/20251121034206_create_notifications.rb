class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
      t.datetime :notification_sent_timestamp, null: true
      t.boolean :email_notification_successfully_sent, null: true
      t.references :task
      t.references :user

      t.timestamps
    end
    add_foreign_key :notifications, :tasks, column: :task_id
    add_foreign_key :notifications, :users, column: :user_id
  end
end
