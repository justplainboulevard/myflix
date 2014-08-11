
require 'rails_helper'

RSpec.describe VideosController, type: :controller do

  describe 'GET #show' do

    it_behaves_like 'requires user' do
      let(:action) { get :show, id: video.id }
    end

    set_video

    before :each do
      set_current_user
      get :show, id: video.id
    end

    it 'sets the @video instance variable' do
      expect(assigns(:video)).to eq(video)
    end

    it 'sets the @reviews instance variable' do
      expect(assigns(:reviews)).to match_array(video.reviews)
    end
  end
end
