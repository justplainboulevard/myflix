
require 'rails_helper'

RSpec.describe VideosController, type: :controller do

  let(:current_user) { Fabricate(:user) }

  describe 'POST #search' do

    let(:video) { Fabricate(:video, title: 'AAA') }

    context 'with an authenicated user' do

      before { session[:user_id] = current_user.id }
      before { post :search, query: 'AA' }

      it 'sets the @videos instance variable' do
        expect(assigns(:videos)).to eq([video])
      end
    end

    context 'with an unauthenicated user' do

      before { post :search, query: 'AA' }

      it 'redirects the user to the root path' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
