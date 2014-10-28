
require 'rails_helper'

RSpec.describe UserSignup do

  describe '#sign_up' do

    context 'with valid personal information and valid credit card' do

      let(:customer) { double(:customer, successful?: true) }

      before :each do
        allow(StripeWrapper::Customer).to receive(:create).and_return(customer)
        UserSignup.new(Fabricate.build(:user)).sign_up('a_stripe_token', nil)
      end

      after { ActionMailer::Base.deliveries.clear }

      it 'calls StripeWrapper::Customer' do
        expect(StripeWrapper::Customer).to have_received(:create)
      end

      it 'creates a user in the database' do
        expect(User.count).to eq(1)
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

    context 'by invitation with valid personal information and valid credit card' do

      let(:customer) { double(:customer, successful?: true) }
      let(:user) { Fabricate(:user) }
      let(:invitation) { Fabricate(:invitation, inviter: user, invitee_email_address: 'jdoe@example.com') }

      before :each do
        allow(StripeWrapper::Customer).to receive(:create).and_return(customer)
        UserSignup.new(Fabricate.build(:user, email_address: 'jdoe@example.com', password: 'password', full_name: 'John Doe')).sign_up('a_stripe_token', invitation.token)
        @new_user = User.where(email_address: 'jdoe@example.com').first
      end

      after { ActionMailer::Base.deliveries.clear }

      it 'calls StripeWrapper::Customer' do
        expect(StripeWrapper::Customer).to have_received(:create)
      end

      it 'sends an email' do
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it 'sends an email to the correct recipient' do
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq([@new_user.email_address])
      end

      it 'sends an email with the correct content' do
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include("Welcome to MyFlix, #{@new_user.full_name}!")
      end

      it 'makes the invitee follow the inviter' do
        expect(@new_user.follows?(user)).to eq(true)
      end

      it 'makes the inviter follow the invitee' do
        expect(user.follows?(@new_user)).to eq(true)
      end

      it 'expires the invitation token upon acceptance' do
        expect(invitation.reload.token).to eq(nil)
      end
    end

    context 'with valid personal information and declined credit card' do

      before :each do
        customer = double(:customer, successful?: false, error_message: 'Your card was declined.')
        allow(StripeWrapper::Customer).to receive(:create).and_return(customer)
        UserSignup.new(Fabricate.build(:user)).sign_up('a_stripe_token', nil)
      end

      it 'calls StripeWrapper::Customer' do
        expect(StripeWrapper::Customer).to have_received(:create)
      end

      it 'does not create a new user in the database' do
        expect(User.first).to eq(nil)
        expect(User.count).to eq(0)
      end
    end

    context 'with invalid personal information' do

      before :each do
        UserSignup.new(Fabricate.build(:user, email_address: '')).sign_up('a_stripe_token', nil)
      end

      after { ActionMailer::Base.deliveries.clear }

      it 'does not create a user in the database' do
        expect(User.first).to eq(nil)
      end

      it 'does not charge the user\'s credit card' do
        expect(StripeWrapper::Customer).not_to receive(:create)
      end

      it 'does not send an email' do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
end
