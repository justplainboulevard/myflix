
require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new_with_invitation_token' do

    before :each do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
    end

    it 'sets the @user instance variable with the invitee\'s email address' do
      expect(assigns(:user).email_address).to eq(invitation.invitee_email_address)
    end

    # it 'creates an instance of the User class' do
    #   expect(assigns(:user)).to be_instance_of(User)
    # end

    it 'renders the users/new template' do
      expect(response).to render_template :new
    end

    # it 'responds successfully' do
    #   expect(response).to be_success
    # end

    # it 'responds with an HTTP 200 status code' do
    #   expect(response).to have_http_status(200)
    # end
  end
end
