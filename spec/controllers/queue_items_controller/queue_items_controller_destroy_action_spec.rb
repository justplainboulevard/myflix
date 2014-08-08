
require 'rails_helper'

RSpec.describe QueueItemsController, type: :controller do

  let(:current_user) { Fabricate(:user) }

  describe 'DELETE #destroy' do

    context 'with an authenicated user' do

      before :each do
        session[:user_id] = current_user.id
      end

      context 'if the current user owns the selected queue item' do

        let(:queue_item) { Fabricate(:queue_item, user_id: current_user.id) }

        before :each do
          delete :destroy, id: queue_item.id
        end

        it 'deletes the selected queue item from the database' do
          expect(QueueItem.count).to eq(0)
        end

        it 'flashes a warning alert' do
          expect(flash[:warning]).not_to be_blank
        end

        it 'redirects the user to the queue items page' do
          expect(response).to redirect_to my_queue_path
        end

        it 'responds with an HTTP 302 status code' do
          expect(response).to have_http_status(302)
        end
      end

      context 'if the current user does not own the selected queue item' do

        let(:queue_item) { Fabricate(:queue_item) }

        before :each do
          delete :destroy, id: queue_item.id
        end

        it 'does not delete the selected queue item from the database if the current user does not own it' do
          expect(QueueItem.count).to eq(1)
        end

        it 'redirects the user to the queue items page' do
          expect(response).to redirect_to my_queue_path
        end

        it 'responds with an HTTP 302 status code' do
          expect(response).to have_http_status(302)
        end
      end
    end

    context 'with an unauthenicated user' do

      let(:queue_item) { Fabricate(:queue_item) }

      before :each do
        delete :destroy, id: queue_item.id
      end

      it 'does not delete the selected queue item from the database' do
        expect(QueueItem.count).to eq(1)
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
