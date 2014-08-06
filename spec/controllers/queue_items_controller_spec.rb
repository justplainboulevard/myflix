
require 'rails_helper'

RSpec.describe QueueItemsController, type: :controller do

  let(:current_user) { Fabricate(:user) }

  describe 'GET #index' do

    context 'with an authenicated user' do

      let(:queue_items) { Fabricate.times(2, :queue_item, user_id: current_user.id) }

      before do
        session[:user_id] = current_user.id
        get :index
      end

      it 'sets the @queue_items instance variable' do
        expect(assigns(:queue_items)).to match_array(queue_items)
      end
    end

    context 'with an unauthenicated user' do

      before { get :index }

      it 'redirects the user to the root path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #create' do

    context 'with an authenicated user' do

      let(:video) { Fabricate(:video) }

      before { session[:user_id] = current_user.id }

      context 'where the selected video is not already in the queue' do

        it 'creates a queue item in the database' do
          post :create, video_id: video.id, user_id: current_user.id
          expect(QueueItem.count).to eq(1)
        end

        it 'associates the @queue_item instance variable with the current user' do
          post :create, video_id: video.id, user_id: current_user.id
          expect(QueueItem.first.user).to eq(current_user)
        end

        it 'associates the @queue_item instance variable with the @video instance variable' do
          post :create, video_id: video.id, user_id: current_user.id
          expect(QueueItem.first.video).to eq(video)
        end

        # it 'flashes a success alert' do
        #   expect(flash[:success]).not_to be_blank
        # end

        it 'redirects the user to the my queue path' do
          post :create, video_id: video.id, user_id: current_user.id
          expect(response).to redirect_to my_queue_path
        end

        it 'adds the new queue item to the end of the queue' do
          other_video = Fabricate(:video)
          Fabricate(:queue_item, video_id: other_video.id, user_id: current_user.id)
          post :create, video_id: video.id, user_id: current_user.id
          new_queue_item = QueueItem.where(video_id: video.id, user_id: current_user.id).first
          expect(new_queue_item.list_order).to eq(2)
        end
      end

      context 'where the selected video is already in the queue' do

        before do
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
      end
    end

    context 'with an unauthenicated user' do

      before { post :create, queue_item: Fabricate.attributes_for(:queue_item) }

      it 'redirects the user to the root path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do

    context 'with an authenicated user' do

      before { session[:user_id] = current_user.id }

      context 'if the current user owns the selected queue item' do

        let(:queue_item) { Fabricate(:queue_item, user_id: current_user.id) }
        before { delete :destroy, id: queue_item.id }

        it 'deletes the selected queue item from the database' do
          expect(QueueItem.count).to eq(0)
        end

        it 'flashes a warning alert' do
          expect(flash[:warning]).not_to be_blank
        end

        it 'redirects the user to the queue items page' do
          expect(response).to redirect_to my_queue_path
        end
      end

      context 'if the current user does not own the selected queue item' do

        let(:queue_item) { Fabricate(:queue_item) }
        before { delete :destroy, id: queue_item.id }

        it 'does not delete the selected queue item from the database if the current user does not own it' do
          expect(QueueItem.count).to eq(1)
        end

        it 'redirects the user to the queue items page' do
          expect(response).to redirect_to my_queue_path
        end
      end
    end

    context 'with an unauthenicated user' do

      let(:video) { Fabricate(:video) }
      let(:queue_item) { Fabricate(:queue_item, video_id: video.id) }

      before { delete :destroy, id: queue_item.id, video_id: video.id }

      it 'redirects the user to the root path' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
