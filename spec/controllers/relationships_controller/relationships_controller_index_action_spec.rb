
require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do

  describe 'GET #index' do

    it_behaves_like 'requires user' do
      let(:action) { get :index }
    end

    before { relationships_controller_index_action_spec_setup }
    before { get :index }

    it 'sets the @relationships instance variable to the current user\'s following relationships' do
      expect(assigns(:relationships)).to eq([@relationship])
    end

    it 'renders the relationships/index template' do
      expect(response).to render_template :index
    end

    it 'responds successfully' do
      expect(response).to be_success
    end

    it 'responds with an HTTP 200 status code' do
      expect(response).to have_http_status(200)
    end
  end

  def relationships_controller_index_action_spec_setup
    user = Fabricate(:user)
    session[:user_id] = user.id
    another_user = Fabricate(:user)
    @relationship = Fabricate(:relationship, follower_id: user.id, leader_id: another_user.id)
  end
end
