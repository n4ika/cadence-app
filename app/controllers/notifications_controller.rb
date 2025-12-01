class NotificationsController < ApplicationController
  def recent
    @notifications = current_user.notifications.unread.recent(5)
    @notifications.each(&:mark_as_read!)

    render partial: "notifications/dropdown"
  end

  def unread_count
    count = current_user.notifications.unread.count
    render json: { count: count }
  end
end
