
require 'rails_helper'

RSpec.describe VideosController, type: :controller do

  describe 'GET #index' do

    it_behaves_like 'requires user' do
      let(:action) { get :index }
    end

    set_categories
    set_videos

    before :each do
      set_current_user
      get :index
    end

    it 'sets the @videos instance variable' do
      expect(assigns(:videos)).to match_array(videos)
    end

    it 'sets the @categories instance variable' do
      expect(assigns(:categories)).to match_array(categories)
    end
  end
end
