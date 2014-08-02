
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe 'GET #new' do

    context 'with an authenicated user' do

      before { session[:user_id] = Fabricate(:user).id }
      before { get :new }

      it 'redirects the user to the home path' do
        expect(response).to redirect_to home_path
      end
    end

    context 'with an unauthenicated user' do

      before { get :new }

      it 'renders the sessions/new template' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #create' do

    let(:user) { Fabricate(:user) }

    context 'with valid credentials' do

      before { post :create, email_address: user.email_address, password: user.password }

      it 'assigns the current user to the session' do
        expect(session[:user_id]).to eq(user.id)
      end

      it 'flashes a success alert' do
        expect(flash[:success]).not_to be_blank
      end

      it 'redirects the user to the home path' do
        expect(response).to redirect_to home_path
      end
    end

    context 'with invalid credentials' do

      before { post :create, email_address: user.email_address + 'abcde', password: user.password }

      it 'does not assign the current user to the session' do
        expect(session[:user_id]).to be_nil
      end

      it 'flashes a danger alert' do
        expect(flash[:danger]).not_to be_blank
      end

      it 'renders the sessions/new template' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #destroy' do

    before { session[:user_id] = Fabricate(:user).id }
    before { get :destroy }

    it 'sets the session to nil' do
      expect(session[:user_id]).to be_nil
    end

    it 'flashes a success alert' do
      expect(flash[:success]).not_to be_blank
    end

    it 'redirects the user to the root path' do
      expect(response).to redirect_to root_path
    end
  end
end
