
require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'POST #create' do

    context 'with valid attributes' do

      before :each do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it 'sets the @user instance variable' do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it 'creates a user in the database' do
        expect(User.count).to eq(1)
      end

      it 'redirects the user to the sign in path' do
        expect(response).to redirect_to signin_path
      end

      it 'responds with an HTTP 302 status code' do
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid attributes' do

      before :each do
        post :create, user: Fabricate.attributes_for(:user, email_address: '')
      end

      it 'sets the @user instance variable' do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it 'does not create a user in the database' do
        expect(User.first).to eq(nil)
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
  end
end
