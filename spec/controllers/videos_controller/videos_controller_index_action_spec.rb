
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
end
