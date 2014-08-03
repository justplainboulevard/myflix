
require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  let(:current_user) { Fabricate(:user) }

  describe 'GET #front' do

    context 'with an authenicated user' do

      before { session[:user_id] = current_user.id }
      before { get :front }

      it 'redirects the user to the home path' do
        expect(response).to redirect_to home_path
      end
    end

    context 'with an unauthenicated user' do

      before { get :front }

      it 'renders the pages/front template' do
        expect(response).to render_template :front
      end
    end
  end
end
