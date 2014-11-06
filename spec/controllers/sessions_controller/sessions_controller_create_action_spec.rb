
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe 'POST #create' do

    set_user

    context 'with valid credentials' do

      before :each do
        post :create, email_address: user.email_address, password: user.password, active: true
      end

      it 'assigns the current user to the session' do
        expect(session[:user_id]).to eq(user.id)
      end

      it 'flashes a success alert' do
        expect(flash[:success]).not_to be_blank
      end

      it 'redirects the user to the home path' do
        expect(response).to redirect_to home_path
      end

      it 'responds with an HTTP 302 status code' do
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid credentials' do

      before :each do
        post :create, email_address: user.email_address + 'abcde', password: user.password, active: true
      end

      it 'does not assign the current user to the session' do
        expect(session[:user_id]).to be_nil
      end

      it 'flashes a danger alert' do
        expect(flash[:danger]).not_to be_blank
      end

      it 'renders the sessions/new template' do
        expect(response).to render_template :new
      end

      it 'responds with an HTTP 200 status code' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when inactive' do

      let(:inactive_user) { Fabricate(:user, active: false) }

      before :each do
        post :create, email_address: inactive_user.email_address, password: inactive_user.password
      end

      it 'does not assign the current user to the session' do
        expect(session[:user_id]).to be_nil
      end

      it 'flashes a danger alert' do
        expect(flash[:danger]).not_to be_blank
      end

      it 'renders the sessions/new template' do
        expect(response).to render_template :new
      end

      it 'responds with an HTTP 200 status code' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
