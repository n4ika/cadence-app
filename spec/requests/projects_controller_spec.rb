require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:other_project) { create(:project, user: other_user) }

  describe "GET /projects/:id/edit" do
    context "when user is signed in" do
      before { sign_in_user(user) }

      it "allows access to own project" do
        get edit_project_path(project)

        expect(response).to have_http_status(:success)
      end

      it "denies access to another user's project" do
        get edit_project_path(other_project)

        expect(response).to have_http_status(:not_found)
      end
    end

    context "when user is not signed in" do
      it "redirects to sign in page" do
        get edit_project_path(project)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PATCH /projects/:id" do
    before { sign_in_user(user) }

    it "allows updating own project" do
      patch project_path(project), params: { project: { title: "Updated Title" } }

      expect(response).to redirect_to(root_path)
      expect(project.reload.title).to eq("Updated Title")
    end

    it "denies updating another user's project" do
      original_title = other_project.title

      patch project_path(other_project), params: { project: { title: "Hacked!" } }

      expect(response).to have_http_status(:not_found)
      expect(other_project.reload.title).to eq(original_title)
    end
  end
end