class CheckDeadlinesJob < ApplicationJob
  queue_as :default

  def perform
    today = Date.today
    tomorrow = today + 1.day
    day_after_tomorrow = today + 2.days

    # Find tasks by deadline urgency
    due_in_48_hours = Task.where(due_date: day_after_tomorrow, status: ['pending', 'in_progress'])
    due_in_24_hours = Task.where(due_date: tomorrow, status: ['pending', 'in_progress'])
    overdue = Task.where("due_date < ? AND status IN (?)", today, ['pending', 'in_progress'])

    # Process each group
    process_tasks(due_in_48_hours, "48_hour")
    process_tasks(due_in_24_hours, "24_hour")
    process_tasks(overdue, "overdue")
  end

  private

  def process_tasks(tasks, urgency_level)
    tasks.each do |task|

      if Notification.exists?(task_id: task.id)
        next
      end

      user = task.project.user

      # Only proceed if user has at least one notification preference enabled
      if user.email_notifications_enabled || user.in_app_notifications_enabled
        message = urgency_message(task, urgency_level)
        notification = Notification.create(
          task_id: task.id, 
          user_id: user.id,
          message: message
        )

        if user.email_notifications_enabled
          UserMailer.deadline_notification(notification).deliver_now
        end

        if user.in_app_notifications_enabled
          notification.update(in_app_notification_successfully_sent: true)
        end
      end
    end
  end


  def urgency_message(task, urgency_level)
    case urgency_level
    when "48_hour"
      "Reminder: #{task.title} is due in 2 days"
    when "24_hour"
      "⚠️ URGENT: #{task.title} is due tomorrow"
    when "overdue"
      "OVERDUE: #{task.title} was due on #{task.due_date}"
    end
  end
end
