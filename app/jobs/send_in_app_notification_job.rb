class SendInAppNotificationJob < ApplicationJob
  queue_as :default

  def perform(notification_id)
    notification = Notification.find(notification_id)
    notification.update(in_app_notification_successfully_sent: true)
  end
end