
require 'rails_helper'

RSpec.describe VideosController, type: :controller do

  describe 'GET #show' do

    let(:current_user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }

    context 'with an authenicated user' do

      before { session[:user_id] = current_user.id }

      it 'sets the @video instance variable' do
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end
    end

    context 'with an unauthenicated user' do

      it 'redirects the user to the root path' do
        get :show, id: video.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #search' do

    let(:current_user) { Fabricate(:user) }
    let(:video) { Fabricate(:video, title: 'AAA') }

    context 'with an authenicated user' do

      before { session[:user_id] = current_user.id }

      it 'sets the @videos instance variable' do
        post :search, query: 'AA'
        expect(assigns(:videos)).to eq([video])
      end
    end

    context 'with an unauthenicated user' do

      it 'redirects the user to the root path' do
        post :search, query: 'AA'
        expect(response).to redirect_to root_path
      end
    end
  end
end
