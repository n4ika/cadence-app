require 'rails_helper'

RSpec.describe CheckDeadlinesJob, type: :job do
  describe '#perform' do
    let(:user) { create(:user, email_notifications_enabled: true, in_app_notifications_enabled: true) }
    let(:project) { create(:project, user: user) }

    it 'creates notifications for tasks due in 48 hours' do
      day_after_tomorrow = Date.current + 2.days
      task = create(:task, project: project, due_date: day_after_tomorrow, status: 'pending')

      expect {
        CheckDeadlinesJob.perform_now
      }.to change { Notification.count }.by(1)

      notification = Notification.last
      expect(notification.task).to eq(task)
      expect(notification.user).to eq(user)
    end

    it 'does not create duplicate notifications for the same task' do
      day_after_tomorrow = Date.current + 2.days
      task = create(:task, project: project, due_date: day_after_tomorrow, status: 'pending')

      # Run job twice
      CheckDeadlinesJob.perform_now

      expect {
        CheckDeadlinesJob.perform_now
      }.not_to change { Notification.count }
    end

    it 'skips completed tasks' do
      day_after_tomorrow = Date.current + 2.days
      task = create(:task, project: project, due_date: day_after_tomorrow, status: 'completed')

      expect {
        CheckDeadlinesJob.perform_now
      }.not_to change { Notification.count }
    end
  end
end