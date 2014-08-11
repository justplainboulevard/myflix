
require 'rails_helper'

RSpec.describe QueueItemsController, type: :controller do

  describe 'GET #index' do

    let(:queue_items) { Fabricate.times(2, :queue_item, user_id: current_user.id) }

    it_behaves_like 'requires user' do
      let(:action) { get :index }
    end

    before :each do
      set_current_user
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
end
