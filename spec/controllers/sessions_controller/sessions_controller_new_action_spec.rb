
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe 'GET #new' do

    context 'with an authenicated user' do

      before :each do
        session[:user_id] = Fabricate(:user).id
        get :new
      end

      it 'redirects the user to the home path' do
        expect(response).to redirect_to home_path
      end

      it 'responds with an HTTP 302 status code' do
        expect(response).to have_http_status(302)
      end
    end

    context 'with an unauthenicated user' do

      before :each do
        get :new
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
