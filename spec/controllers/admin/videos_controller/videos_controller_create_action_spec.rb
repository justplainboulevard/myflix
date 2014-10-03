
require 'rails_helper'

RSpec.describe Admin::VideosController, type: :controller do

  describe 'POST #create' do

    it_behaves_like 'requires user' do
      let(:action) { post :create }
    end

    it_behaves_like 'requires admin' do
      let(:action) { post :create }
    end

    context 'with valid attributes' do

      before do
        set_current_admin
        @category_1 = Fabricate(:category)
        @category_2 = Fabricate(:category)
        post :create, video: Fabricate.attributes_for(:video, category_ids: [@category_1.id, @category_2.id])
      end

      it 'sets the @video instance variable' do
        expect(assigns(:video)).to be_instance_of(Video)
      end

      it 'creates a video in the database' do
        expect(Video.count).to eq(1)
      end

      it 'creates a video in the database' do
        expect(@category_1.videos.count).to eq(1)
        expect(@category_2.videos.count).to eq(1)
      end

      it 'flashes a success alert' do
        expect(flash[:success]).to be_present
      end

      it 'redirects the user to the new admin video path' do
        expect(response).to redirect_to new_admin_video_path
      end

      it 'responds with an HTTP 302 status code' do
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid attributes' do

      before do
        set_current_admin
        @category_1 = Fabricate(:category)
        @category_2 = Fabricate(:category)
        post :create, video: Fabricate.attributes_for(:video, title: '', category_ids: [@category_1.id, @category_2.id])
      end

      it 'sets the @video instance variable' do
        expect(assigns(:video)).to be_instance_of(Video)
      end

      it 'does not create a video in the database' do
        expect(Video.first).to eq(nil)
      end

      it 'does not create a video in the database' do
        expect(@category_1.videos.count).to eq(0)
        expect(@category_2.videos.count).to eq(0)
      end

      it 'renders the admin/videos/new template' do
        expect(response).to render_template :new
      end

      it 'flashes a danger alert' do
        expect(flash[:danger]).to be_present
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
