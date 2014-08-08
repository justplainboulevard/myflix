
require 'rails_helper'

RSpec.describe QueueItemsController, type: :controller do

  let(:current_user) { Fabricate(:user) }
  let(:queue_items) { Fabricate.times(2, :queue_item, user_id: current_user.id) }

  describe 'GET #index' do

    context 'with an authenicated user' do

      before :each do
        session[:user_id] = current_user.id
        get :index
      end

      it 'sets the @queue_items instance variable' do
        expect(assigns(:queue_items)).to match_array(queue_items)
      end

      it 'renders the queue_items/index template' do
        expect(response).to render_template :index
      end

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'responds with an HTTP 200 status code' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with an unauthenicated user' do

      before :each do
        get :index
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
