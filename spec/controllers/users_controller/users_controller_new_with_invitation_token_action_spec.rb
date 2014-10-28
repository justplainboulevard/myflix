
require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new_with_invitation_token' do

    context 'with a valid token' do

      let(:invitation) { Fabricate(:invitation) }

      before { get :new_with_invitation_token, token: invitation.token }

      it 'sets the @user instance variable with the invitee\'s email address' do
        expect(assigns(:user).email_address).to eq(invitation.invitee_email_address)
      end

      it 'sets the @invitation_token instance variable' do
        expect(assigns(:invitation_token)).to eq(invitation.token)
      end

      it 'creates an instance of the User class' do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it 'renders the users/new template' do
        expect(response).to render_template :new
      end

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'responds with an HTTP 200 status code' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with an invalid token' do

      before { get :new_with_invitation_token, token: 'invalid_token' }

      it 'redirects the invitee to the expired token path' do
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end
