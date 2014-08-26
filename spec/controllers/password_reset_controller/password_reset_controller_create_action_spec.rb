
require 'rails_helper'

RSpec.describe PasswordResetController, type: :controller do

  describe 'POST #create' do

    context 'where the user does not submit an email address' do

      before { post :create, email_address: '' }

      it 'redirects to the forgot password page' do
        expect(response).to redirect_to forgot_password_path
      end

      it 'flashes an error message' do
        expect(flash[:danger]).to eq('Email address cannot be blank.')
      end
    end

    context 'where the user submits an invalid email address' do

      before :each do
        Fabricate(:user, email_address: 'jdoe@example.com')
        post :create, email_address: 'jsmith@example.com'
      end

      it 'redirects to the forgot password page' do
        expect(response).to redirect_to forgot_password_path
      end

      it 'flashes an error message' do
        expect(flash[:danger]).to eq('You submitted an invalid email address.')
      end
    end

    context 'where the user submits a valid email address' do

      before :each do
        Fabricate(:user, email_address: 'jdoe@example.com')
        post :create, email_address: 'jdoe@example.com'
      end

      it 'redirects to the password reset confirmation page' do
        expect(response).to redirect_to password_reset_confirmation_path
      end

      it 'sends an email to the user\'s email address' do
        expect(ActionMailer::Base.deliveries.last.to).to eq(['jdoe@example.com'])
      end
    end
  end
end
