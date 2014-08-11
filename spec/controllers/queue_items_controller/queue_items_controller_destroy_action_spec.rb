
require 'rails_helper'

RSpec.describe QueueItemsController, type: :controller do

  describe 'DELETE #destroy' do

    it_behaves_like 'requires user' do
      let(:action) { delete :destroy, id: Fabricate(:queue_item).id }
    end

    before :each do
      set_current_user
    end

    context 'if the current user owns the selected queue item' do

      before :each do
        queue_item = Fabricate(:queue_item, user_id: current_user.id, list_order: 1)
        Fabricate(:queue_item, user_id: current_user.id, list_order: 2)
        delete :destroy, id: queue_item.id
      end

      it 'deletes the selected queue item from the database' do
        expect(QueueItem.count).to eq(1)
      end

      it 'normalizes the queue item position numbers of the remaining queue items' do
        expect(QueueItem.first.list_order).to eq(1)
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

      set_user
      set_video
      set_queue_item

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
end
