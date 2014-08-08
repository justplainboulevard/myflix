
require 'rails_helper'

RSpec.describe QueueItemsController, type: :controller do

  let(:current_user) { Fabricate(:user) }

  describe 'POST #update_queue' do

    context 'with an authenicated user' do

      before :each do
        session[:user_id] = current_user.id
      end

      context 'if the current user owns the selected queue item' do

        context 'with valid input' do

          it 'reorders the queue items' do
            queue_item_1 = Fabricate(:queue_item, user_id: current_user.id, list_order: 1)
            queue_item_2 = Fabricate(:queue_item, user_id: current_user.id, list_order: 2)
            post :update_queue, queue_items: [{id: queue_item_1.id, list_order: 2}, {id: queue_item_2.id, list_order: 1}]
            expect(current_user.queue_items).to eq([queue_item_2, queue_item_1])
          end

          it 'normalizes the queue item position numbers' do
            queue_item_1 = Fabricate(:queue_item, user_id: current_user.id, list_order: 1)
            queue_item_2 = Fabricate(:queue_item, user_id: current_user.id, list_order: 2)
            post :update_queue, queue_items: [{id: queue_item_1.id, list_order: 3}, {id: queue_item_2.id, list_order: 2}]
            expect(current_user.queue_items.map(&:list_order)).to eq([1, 2])
          end

          # ALTERNATE APPROACH AS PER SOLUTION VIDEO; DOWNSIDE, AS EXPLAINED, IS NEED TO RELOAD TO RETRIEVE UPDATED RECORDS FROM THE DATEBASE. FIRST APPROACH DOES THAT BY CALLING QUEUE_ITEMS ON THE CURRENT_USER.

          it 'normalizes the queue item position numbers' do
            queue_item_1 = Fabricate(:queue_item, user_id: current_user.id, list_order: 1)
            queue_item_2 = Fabricate(:queue_item, user_id: current_user.id, list_order: 2)
            post :update_queue, queue_items: [{id: queue_item_1.id, list_order: 3}, {id: queue_item_2.id, list_order: 2}]
            expect(queue_item_1.reload.list_order).to eq(2)
            expect(queue_item_2.reload.list_order).to eq(1)
          end

          it 'redirects the user to the my queue path' do
            queue_item_1 = Fabricate(:queue_item, user_id: current_user.id, list_order: 1)
            queue_item_2 = Fabricate(:queue_item, user_id: current_user.id, list_order: 2)
            post :update_queue, queue_items: [{id: queue_item_1.id, list_order: 2}, {id: queue_item_2.id, list_order: 1}]
            expect(response).to redirect_to my_queue_path
          end
        end

        context 'with invalid input' do
        end
      end

      context 'if the current user does not own the selected queue item' do
      end
    end

    context 'with an unauthenicated user' do

      let(:queue_item) { Fabricate(:queue_item) }

      before :each do
        post :update_queue, id: queue_item.id
      end

      it 'does not update the queue' do

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
