require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'scopes' do
    describe '.unread' do
      it 'returns notifications without read_at timestamp' do
        unread_notification = create(:notification, read_at: nil)
        read_notification = create(:notification, read_at: Time.current)

        unread_notifications = Notification.unread

        expect(unread_notifications).to include(unread_notification)
        expect(unread_notifications).not_to include(read_notification)
      end
    end

    describe '.recent' do
      it 'returns notifications ordered by created_at desc with limit' do
        # Create notifications with different timestamps
        old = create(:notification, created_at: 3.days.ago)
        middle = create(:notification, created_at: 2.days.ago)
        recent = create(:notification, created_at: 1.day.ago)

        recent_notifications = Notification.recent(2)

        expect(recent_notifications).to eq([recent, middle])
        expect(recent_notifications).not_to include(old)
      end
    end
  end

  describe 'instance methods' do
    describe '#read?' do
      it 'returns true when read_at is present' do
        notification = create(:notification, read_at: Time.current)
        expect(notification.read?).to be true
      end

      it 'returns false when read_at is nil' do
        notification = create(:notification, read_at: nil)
        expect(notification.read?).to be false
      end
    end

    describe '#unread?' do
      it 'returns true when read_at is nil' do
        notification = create(:notification, read_at: nil)
        expect(notification.unread?).to be true
      end

      it 'returns false when read_at is present' do
        notification = create(:notification, read_at: Time.current)
        expect(notification.unread?).to be false
      end
    end

    describe '#mark_as_read!' do
      it 'sets read_at to current time' do
        notification = create(:notification, read_at: nil)

        expect {
          notification.mark_as_read!
        }.to change { notification.reload.read_at }.from(nil)

        expect(notification.read_at).to be_present
      end
    end
  end
end
