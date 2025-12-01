require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:other_project) { create(:project, user: other_user) }
  let(:task) { create(:task, project: project) }
  let(:other_task) { create(:task, project: other_project) }

  describe "GET /projects/:project_id/tasks/:id/edit" do
    context "when user is signed in" do
      before { sign_in_user(user) }

      it "allows access to task in own project" do
        get edit_project_task_path(project, task)

        expect(response).to have_http_status(:success)
      end

      it "denies access to task in another user's project" do
        get edit_project_task_path(other_project, other_task)

        expect(response).to have_http_status(:not_found)
      end
    end

    context "when user is not signed in" do
      it "redirects to sign in page" do
        get edit_project_task_path(project, task)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE /projects/:project_id/tasks/:id" do
    before { sign_in_user(user) }

    it "allows deleting task in own project" do
      task_to_delete = create(:task, project: project)

      expect {
        delete project_task_path(project, task_to_delete)
      }.to change { Task.count }.by(-1)

      expect(response).to redirect_to(root_path)
    end

    it "denies deleting task in another user's project" do
      other_task

      expect {
        delete project_task_path(other_project, other_task)
      }.not_to change { Task.count }

      expect(response).to have_http_status(:not_found)
    end

    it "deletes associated notifications" do
      task_with_notification = create(:task, project: project)
      create(:notification, task: task_with_notification, user: user)

      expect {
        delete project_task_path(project, task_with_notification)
      }.to change { Notification.count }.by(-1)
    end
  end
end
