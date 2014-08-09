
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe 'GET #destroy' do

    before :each do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it 'sets the session to nil' do
      expect(session[:user_id]).to be_nil
    end

    it 'flashes a success alert' do
      expect(flash[:success]).not_to be_blank
    end

    it 'redirects the user to the root path' do
      expect(response).to redirect_to root_path
    end

    it 'responds with an HTTP 302 status code' do
      expect(response).to have_http_status(302)
    end
  end
end
