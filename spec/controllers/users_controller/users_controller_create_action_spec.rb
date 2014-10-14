
require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'POST #create' do

    context 'with valid personal information and valid credit card' do

      before :each do
        charge = double(:charge, successful?: true)
        allow(StripeWrapper::Charge).to receive(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user)
      end

      after { ActionMailer::Base.deliveries.clear }

      it 'sets the @user instance variable' do
        expect(assigns(:user)).to be_instance_of(User)
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

    context 'by invitation with valid personal information and valid credit card' do

      before :each do
        @user = Fabricate(:user)
        @invitation = Fabricate(:invitation, inviter: @user, invitee_email_address: 'jdoe@example.com')
        charge = double(:charge, successful?: true)
        allow(StripeWrapper::Charge).to receive(:create).and_return(charge)
        post :create, user: { email_address: 'jdoe@example.com', password: 'password', full_name: 'John Doe' }, invitation_token: @invitation.token
        @new_user = User.where(email_address: 'jdoe@example.com').first
      end

      after { ActionMailer::Base.deliveries.clear }

      it 'makes the invitee follow the inviter' do
        expect(@new_user.follows?(@user)).to eq(true)
      end

      it 'makes the inviter follow the invitee' do
        expect(@user.follows?(@new_user)).to eq(true)
      end

      it 'expires the invitation token upon acceptance' do
        expect(@invitation.reload.token).to eq(nil)
      end
    end

    context 'with valid personal information and declined credit card' do

      before :each do
        charge = double(:charge, successful?: false, error_message: 'Your card was declined.')
        allow(StripeWrapper::Charge).to receive(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '12341234'
      end

      it 'does not create a new user in the database' do
        expect(User.first).to eq(nil)
        expect(User.count).to eq(0)
      end

      it 'flashes an error alert' do
        expect(flash[:error]).not_to be_blank
        expect(flash[:error]).to be_present
      end

      it 'renders the users/new template' do
        expect(response).to render_template :new
      end
    end

    context 'with invalid personal information' do

      before :each do
        charge = double(:charge, successful?: true)
        allow(StripeWrapper::Charge).to receive(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user, email_address: '')
      end

      after { ActionMailer::Base.deliveries.clear }

      it 'sets the @user instance variable' do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it 'does not create a user in the database' do
        expect(User.first).to eq(nil)
      end

      it 'does not charge the user\'s credit card' do

      end

      it 'renders the users/new template' do
        expect(response).to render_template :new
      end

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'responds with an HTTP 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'does not send an email' do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
end
