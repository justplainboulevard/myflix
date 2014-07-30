
require 'rails_helper'

RSpec.describe VideosController do

  describe 'GET #show' do

    context 'with an authenicated user' do

      before do
        session[:user_id] = Fabricate(:user).id
      end

      it 'sets the @video instance variable' do
        video = Fabricate(:video)

        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end
    end

    context 'with an unauthenicated user' do

      it 'redirects the user to the root path' do
        video = Fabricate(:video)

        get :show, id: video.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #search' do

    context 'with an authenicated user' do

      before do
        session[:user_id] = Fabricate(:user).id
      end

      it 'sets the @videos instance variable' do
        video_a = Fabricate(:video, title: 'AAA')

        post :search, query: 'AA'
        expect(assigns(:videos)).to eq([video_a])
      end
    end

    context 'with an unauthenicated user' do

      it 'redirects the user to the root path' do
        video_a = Fabricate(:video, title: 'AAA')

        post :search, query: 'AA'
        expect(response).to redirect_to root_path
      end
    end
  end
end
