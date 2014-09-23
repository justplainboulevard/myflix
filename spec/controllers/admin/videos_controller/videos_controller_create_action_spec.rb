
require 'rails_helper'

RSpec.describe Admin::VideosController, type: :controller do

  describe 'POST #create' do

    context 'with valid attributes' do

      before { post :create, video: Fabricate.attributes_for(:video) }

      it 'sets the @video instance variable' do
        expect(assigns(:video)).to be_instance_of(Video)
      end

      # it 'creates a video in the database' do
      #   expect(Video.count).to eq(1)
      # end

      # it 'redirects the user to the new admin video path' do
      #   expect(response).to redirect_to new_admin_video_path
      # end

      # it 'responds with an HTTP 302 status code' do
      #   expect(response).to have_http_status(302)
      # end
    end

    # context 'with invalid attributes' do

    #   before { post :create, video: Fabricate.attributes_for(:video, title: '') }

    #   it 'sets the @video instance variable' do
    #     expect(assigns(:video)).to be_instance_of(Video)
    #   end

    #   it 'does not create a video in the database' do
    #     expect(Video.first).to eq(nil)
    #   end

    #   it 'renders the admin/videos/new template' do
    #     expect(response).to render_template :new
    #   end

    #   it 'responds successfully' do
    #     expect(response).to be_success
    #   end

    #   it 'responds with an HTTP 200 status code' do
    #     expect(response).to have_http_status(200)
    #   end
    # end
  end
end
