
require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do

  describe 'POST #create' do

    # context 'where the user does not submit a friend\'s email address' do

    #   before { post :create, friend_email_address: '' }

    #   it 'redirects to the forgot password page' do
    #     expect(response).to redirect_to new_invitation_path
    #   end

    #   it 'flashes an error message' do
    #     expect(flash[:danger]).to eq('Email address cannot be blank.')
    #   end
    # end

    # context 'where the user submits an invalid email address' do

    #   before :each do
    #     # SET INVALID PASSWORD
    #     post :create, friend_email_address: 'jsmith$example.com'
    #   end

    #   it 'redirects to the forgot password page' do
    #     expect(response).to redirect_to new_invitation_path
    #   end

    #   it 'flashes an error message' do
    #     expect(flash[:danger]).to eq('You submitted an invalid email address.')
    #   end
    # end

    context 'where the user submits a valid email address' do

      before :each do
        # SET VALID PASSWORD
        post :create, friend_name: 'John Doe', friend_email_address: 'jdoe@example.com'
      end

      it 'redirects to the invitation confirmation page' do
        expect(response).to redirect_to invitation_confirmation_path
      end

      it 'sends an email to the user\'s friend\'s email address' do
        expect(ActionMailer::Base.deliveries.last.to).to eq(['jdoe@example.com'])
      end
    end
  end
end
