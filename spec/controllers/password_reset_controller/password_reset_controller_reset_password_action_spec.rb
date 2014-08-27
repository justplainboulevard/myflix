
require 'rails_helper'

RSpec.describe PasswordResetController, type: :controller do

  describe 'POST #reset_password' do

    context 'where the reset password token is valid' do

      let(:user) { Fabricate(:user, password: 'old_password') }

      before :each do
        user.update_column(:token, 'abcde')
        post :reset_password, id: 'abcde', token: 'abcde', password: 'new_password'
      end

      it 'updates the user\'s password' do
        expect(user.reload.authenticate('new_password')).to eq(user)
      end

      it 'regenerates the user\'s token' do
        expect(user.reload.token).not_to eq('abcde')
      end

      it 'redirects to the sign in page' do
        expect(response).to redirect_to signin_path
      end

      it 'flashes a success message' do
        expect(flash[:success]).to be_present
      end
    end

    context 'where the reset password token is invalid' do

      before :each do
        post :reset_password, id: 'fghij', password: 'new_password'
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
