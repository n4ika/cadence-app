require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'scopes' do
    describe '.active' do
      it 'returns tasks with pending or in_progress status' do
        pending_task = create(:task, status: 'pending')
        in_progress_task = create(:task, status: 'in_progress')
        completed_task = create(:task, status: 'completed')

        active_tasks = Task.active

        expect(active_tasks).to include(pending_task, in_progress_task)
        expect(active_tasks).not_to include(completed_task)
      end
    end
    describe '.pending' do
      it 'returns only pending tasks' do
        pending_task = create(:task, status: 'pending')
        in_progress_task = create(:task, status: 'in_progress')

        expect(Task.pending).to include(pending_task)
        expect(Task.pending).not_to include(in_progress_task)
      end
    end

    describe '.completed' do
      it 'returns only completed tasks' do
        pending_task = create(:task, status: 'pending')
        completed_task = create(:task, status: 'completed')

        expect(Task.completed).to include(completed_task)
        expect(Task.completed).not_to include(pending_task)
      end
    end

    describe '.due_on' do
      it 'returns tasks due on a specific date' do
        today = Date.current
        tomorrow = today + 1.day

        task_today = create(:task, due_date: today)
        task_tomorrow = create(:task, due_date: tomorrow)

        expect(Task.due_on(today)).to include(task_today)
        expect(Task.due_on(today)).not_to include(task_tomorrow)
      end
    end

    describe '.overdue' do
      it 'returns active tasks with past due dates' do
        overdue_pending = create(:task, due_date: 2.days.ago, status: 'pending')
        overdue_completed = create(:task, due_date: 2.days.ago, status: 'completed')
        future_task = create(:task, due_date: 2.days.from_now, status: 'pending')

        expect(Task.overdue).to include(overdue_pending)
        expect(Task.overdue).not_to include(overdue_completed, future_task)
      end
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      task = build(:task)
      expect(task).to be_valid
    end

    it 'is invalid without a title' do
      task = build(:task, title: nil)
      expect(task).not_to be_valid
      expect(task.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a due_date' do
      task = build(:task, due_date: nil)
      expect(task).not_to be_valid
      expect(task.errors[:due_date]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs to a project' do
      task = create(:task)
      expect(task.project).to be_present
    end

    it 'has many notifications that are destroyed when task is destroyed' do
      task = create(:task)
      notification = Notification.create!(task: task, user: task.project.user, message: "Test")

      expect { task.destroy }.to change { Notification.count }.by(-1)
    end
  end
end
