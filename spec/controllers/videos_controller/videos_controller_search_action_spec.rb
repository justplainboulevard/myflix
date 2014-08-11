
require 'rails_helper'

RSpec.describe VideosController, type: :controller do

  describe 'POST #search' do

    it_behaves_like 'requires user' do
      let(:action) { post :search, query: 'AA' }
    end

    let(:video) { Fabricate(:video, title: 'AAA') }

    before :each do
      set_current_user
      post :search, query: 'AA'
    end

    it 'sets the @videos instance variable' do
      expect(assigns(:videos)).to eq([video])
    end
  end
end
