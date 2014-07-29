
require 'rails_helper'

RSpec.describe UsersController do

  describe 'GET #new' do

    it 'sets the @user instance variable' do
      get :new
      expect(assigns(:user)).to be_new_record
    end

    it 'creates an instance of the User class' do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end

    it 'responds successfully' do
      get :new
      expect(response).to be_success
    end

    it 'responds with an HTTP 200 status code' do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do

      it 'creates a user record' do
        expect{ post :create, user: FactoryGirl.attributes_for(:user) }.to change(User, :count).by(1)
      end

      it 'redirects to the sign in path' do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to signin_path
      end
    end

    context 'with invalid attributes' do

      it 'does not create a user record' do
        post :create, user: FactoryGirl.attributes_for(:user, email_address: '')
        expect(User.first).to eq(nil)
      end

      it 'renders the new template' do
        post :create, user: FactoryGirl.attributes_for(:user, email_address: '')
        expect(response).to render_template :new
      end
    end
  end
end
