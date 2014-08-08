
require 'rails_helper'

RSpec.describe QueueItemsController, type: :controller do

  let(:current_user) { Fabricate(:user) }
  let(:video) { Fabricate(:video) }

  describe 'POST #create' do

    context 'with an authenicated user' do

      before :each do
        session[:user_id] = current_user.id
      end

      context 'where the selected video is not already in the queue' do

        before :each do
          post :create, video_id: video.id, user_id: current_user.id
        end

        it 'creates a queue item in the database' do
          expect(QueueItem.count).to eq(1)
        end

        it 'associates the @queue_item instance variable with the current user' do
          expect(QueueItem.first.user).to eq(current_user)
        end

        it 'associates the @queue_item instance variable with the @video instance variable' do
          expect(QueueItem.first.video).to eq(video)
        end

        it 'flashes a success alert' do
          expect(flash[:success]).not_to be_blank
        end

        it 'redirects the user to the my queue path' do
          expect(response).to redirect_to my_queue_path
        end

        it 'responds with an HTTP 302 status code' do
          expect(response).to have_http_status(302)
        end
      end

      context 'where the selected video is not already in the queue' do

        before :each do
          other_video = Fabricate(:video)
          Fabricate(:queue_item, video_id: other_video.id, user_id: current_user.id)
          post :create, video_id: video.id, user_id: current_user.id
        end

        it 'adds the new queue item to the end of the queue' do
          new_queue_item = QueueItem.where(video_id: video.id, user_id: current_user.id).first
          expect(new_queue_item.list_order).to eq(2)
        end
      end

      context 'where the selected video is already in the queue' do

        before :each do
          Fabricate(:queue_item, video_id: video.id, user_id: current_user.id)
          post :create, video_id: video.id, user_id: current_user.id
        end

        it 'does not create a queue item in the database' do
          expect(QueueItem.count).to eq(1)
        end

        it 'flashes a success alert' do
          expect(flash[:success]).not_to be_blank
        end

        it 'redirects the user to the my queue path' do
          expect(response).to redirect_to my_queue_path
        end

        it 'responds with an HTTP 302 status code' do
          expect(response).to have_http_status(302)
        end
      end
    end

    context 'with an unauthenicated user' do

      before :each do
        post :create, queue_item: Fabricate.attributes_for(:queue_item)
      end

      it 'redirects the user to the root path' do
        expect(response).to redirect_to root_path
      end

      it 'responds with an HTTP 302 status code' do
        expect(response).to have_http_status(302)
      end
    end
  end
end
