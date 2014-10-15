
require 'rails_helper'

RSpec.describe UserSignup do

  describe '#sign_up' do

    context 'with valid personal information and valid credit card' do

      let(:charge) { double(:charge, successful?: true) }

      before :each do
        allow(StripeWrapper::Charge).to receive(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user)
      end

      after { ActionMailer::Base.deliveries.clear }

      it 'sets the @user instance variable' do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it 'calls StripeWrapper::Charge' do
        expect(StripeWrapper::Charge).to have_received(:create)
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

      it 'sends an email' do
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it 'sends an email to the correct recipient' do
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq([User.first.email_address])
      end

      it 'sends an email with the correct content' do
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include("Welcome to MyFlix, #{User.first.full_name}!")
      end
    end
  end
end
