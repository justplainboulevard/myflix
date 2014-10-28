
require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'POST #create' do

    context 'with successful user signup' do

      let(:result) { double(:sign_up_result, successful?: true) }

      before :each do
        allow_any_instance_of(UserSignup).to receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)
      end

      after { ActionMailer::Base.deliveries.clear }

      it 'sets the @user instance variable' do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it 'flashes a success alert' do
        expect(flash[:success]).to be_present
      end

      it 'redirects the user to the sign in path' do
        expect(response).to redirect_to signin_path
      end

      it 'responds with an HTTP 302 status code' do
        expect(response).to have_http_status(302)
      end
    end

    context 'with failed user signup' do

      let(:result) { double(:sign_up_result, successful?: false, error_message: 'You provided invalid information. Please check the errors noted below.') }

      before :each do
        allow_any_instance_of(UserSignup).to receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)
      end

      after { ActionMailer::Base.deliveries.clear }

      it 'sets the @user instance variable' do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it 'flashes an error alert' do
        expect(flash[:error]).to be_present
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
    end
  end
end
