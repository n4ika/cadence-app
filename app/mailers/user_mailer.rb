class UserMailer < ApplicationMailer
  default from: 'noreply@cadence.local'

  def deadline_notification(notification)
    @notification = notification
    @user = notification.user
    @task = notification.task
    
    mail(to: @user.email, subject: "#{@task.title} Deadline Notification")
  end
end