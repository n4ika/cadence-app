class AddInAppNotificationSuccessfullySentToNotifications < ActiveRecord::Migration[8.1]
  def change
    add_column :notifications, :in_app_notification_successfully_sent, :boolean
  end
end
