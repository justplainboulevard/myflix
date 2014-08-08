
require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  let(:current_user) { Fabricate(:user) }

  describe 'GET #front' do

    context 'with an authenicated user' do

      before :each do
        session[:user_id] = current_user.id
        get :front
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
        get :front
      end

      it 'renders the pages/front template' do
        expect(response).to render_template :front
      end

      it 'responds with an HTTP 200 status code' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
