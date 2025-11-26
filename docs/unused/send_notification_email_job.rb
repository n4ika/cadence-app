# Deprecated for POC - emails now sent synchronously in CheckDeadlinesJob
# Uncomment if switching to async background processing
# class SendNotificationEmailJob < ApplicationJob
#   queue_as :mailers

#   def perform(notification_id)
#     notification = Notification.find(notification_id)
#     user = notification.user

#     UserMailer.deadline_notification(notification).deliver_later
#     notification.update(email_notification_successfully_sent: true)
#   end
# end
