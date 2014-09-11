
require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do

  describe 'POST #create' do

    it_behaves_like 'requires user' do
      let(:action) { post :create }
    end

    context 'where the user does not submit valid data' do

      before :each do
        set_current_user
        ActionMailer::Base.deliveries.clear
        post :create, invitation: { invitee_name: 'John Doe', invitee_email_address: '', invitation_message: 'Join MyFlix' }
      end

      it 'sets the @invitation instance variable' do
        expect(assigns(:invitation)).to be_present
      end

      it 'renders the invitations/new template' do
        expect(response).to render_template :new
      end

      it 'flashes an error message' do
        expect(flash[:danger]).to be_present
      end

      it 'does not create a new invitation' do
        expect(Invitation.count).to eq(0)
      end

      it 'does not send an email' do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end

    context 'where the user submits valid data' do

      before :each do
        set_current_user
        post :create, invitation: { invitee_name: 'John Doe', invitee_email_address: 'jdoe@example.com', invitation_message: 'Join MyFlix' }
      end

      after { ActionMailer::Base.deliveries.clear }

      it 'sets the @invitation instance variable' do
        expect(assigns(:invitation)).to be_present
      end

      it 'creates a new invitation' do
        expect(Invitation.count).to eq(1)
      end

      it 'sends an email to the user\'s friend\'s email address' do
        expect(ActionMailer::Base.deliveries.last.to).to eq(['jdoe@example.com'])
      end

      it 'redirects to the new invitation page' do
        expect(response).to redirect_to new_invitation_path
      end

      it 'flashes a success message' do
        expect(flash[:success]).to be_present
      end
    end
  end
end
