
require 'rails_helper'

RSpec.describe QueueItemsController, type: :controller do

  let(:current_user) { Fabricate(:user) }
  let(:queue_items) { Fabricate.times(2, :queue_item, user_id: current_user.id) }

  describe 'GET #index' do

    context 'with an authenicated user' do

      before { session[:user_id] = current_user.id }
      before { get :index }

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
end
