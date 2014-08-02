
require 'rails_helper'

RSpec.describe VideosController, type: :controller do

  let(:current_user) { Fabricate(:user) }

  describe 'GET #index' do

    let(:categories) { Fabricate.times(3, :category) }
    let(:videos) { Fabricate.times(7, :video) }

    context 'with an authenicated user' do

      before { session[:user_id] = current_user.id }
      before { get :index }

      it 'sets the @videos instance variable' do
        expect(assigns(:videos)).to match_array(videos)
      end

      it 'sets the @categories instance variable' do
        expect(assigns(:categories)).to match_array(categories)
      end
    end

    context 'with an unauthenicated user' do

      before { get :index }

      it 'redirects the user to the root path' do
        expect(response).to redirect_to root_path
      end
    end

  end

  describe 'GET #show' do

    let(:video) { Fabricate(:video) }
    let(:reviews_list) { Fabricate.times(2, :review, video_id: video.id) }

    context 'with an authenicated user' do

      before { session[:user_id] = current_user.id }
      before { get :show, id: video.id }

      it 'sets the @video instance variable' do
        expect(assigns(:video)).to eq(video)
      end

      it 'sets the @reviews instance variable' do
        expect(assigns(:reviews)).to match_array(reviews_list)
      end
    end

    context 'with an unauthenicated user' do

      before { get :show, id: video.id }

      it 'redirects the user to the root path' do
        expect(response).to redirect_to root_path
      end
    end
  end

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
