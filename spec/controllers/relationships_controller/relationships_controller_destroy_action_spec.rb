
require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do

  describe 'DELETE #destroy' do

    it_behaves_like 'requires user' do
      let(:action) { delete :destroy, id: Fabricate(:relationship).id }
    end

    context 'if the current user is the follower' do

      before :each do
        relationships_controller_destroy_action_spec_setup
        delete :destroy, id: @relationship.id
      end

      it 'deletes the selected relationship from the database' do
        expect(QueueItem.count).to eq(0)
      end

      it 'flashes a warning alert' do
        expect(flash[:warning]).not_to be_blank
      end

      it 'redirects the user to the people page' do
        expect(response).to redirect_to people_path
      end

      it 'responds with an HTTP 302 status code' do
        expect(response).to have_http_status(302)
      end
    end

    context 'if the current user is the leader' do

      before :each do
        user = Fabricate(:user)
        session[:user_id] = user.id
        relationship = Fabricate(:relationship)
        delete :destroy, id: relationship.id
      end

      it 'does not delete the selected relationship from the database' do
        expect(Relationship.count).to eq(1)
      end

      it 'redirects the user to the people page' do
        expect(response).to redirect_to people_path
      end

      it 'responds with an HTTP 302 status code' do
        expect(response).to have_http_status(302)
      end
    end
  end

  def relationships_controller_destroy_action_spec_setup
    user = Fabricate(:user)
    session[:user_id] = user.id
    another_user = Fabricate(:user)
    @relationship = Fabricate(:relationship, follower_id: user.id, leader_id: another_user.id)
  end
end
