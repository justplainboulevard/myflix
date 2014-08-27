
require 'rails_helper'

RSpec.describe PasswordResetController, type: :controller do

  describe 'GET #show' do

    context 'where the reset password token is valid' do

      before :each do
        user = Fabricate(:user)
        user.update_column(:token, 'abcde')
        get :show, id: 'abcde'
      end

      it 'renders the password_reset/show template' do
        expect(response).to render_template :show
      end

      it 'sets the @token instance variable' do
        expect(assigns(:token)).to eq('abcde')
      end

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'responds with an HTTP 200 status code' do
        expect(response).to have_http_status(200)
      end
    end

    context 'where the reset password token is invalid' do

      before :each do
        user = Fabricate(:user)
        user.update_column(:token, 'abcde')
        get :show, id: 'fghij'
      end

      it 'redirects to the expired token page' do
        expect(response).to redirect_to expired_token_path
      end

      it 'responds with an HTTP 302 status code' do
        expect(response).to have_http_status(302)
      end
    end
  end
end
