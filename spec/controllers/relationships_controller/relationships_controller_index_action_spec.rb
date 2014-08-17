
require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do

  describe 'GET #index' do

    it_behaves_like 'requires user' do
      let(:action) { get :index }
    end

    before :each do
      get :index
    end

    it 'sets the @relationships instance variable to the current user\'s following relationships' do
      user = Fabricate(:user)
      session[:user_id] = user.id
      another_user = Fabricate(:user)
      relationship = Fabricate(:relationship, follower_id: user.id, leader_id: another_user.id)
      expect(assigns(:relationships)).to eq([relationship])
    end

    it 'renders the relationships/index template' do
      user = Fabricate(:user)
      session[:user_id] = user.id
      another_user = Fabricate(:user)
      relationship = Fabricate(:relationship, follower_id: user.id, leader_id: another_user.id)
      expect(response).to render_template :index
    end

    it 'responds successfully' do
      user = Fabricate(:user)
      session[:user_id] = user.id
      another_user = Fabricate(:user)
      relationship = Fabricate(:relationship, follower_id: user.id, leader_id: another_user.id)
      expect(response).to be_success
    end

    it 'responds with an HTTP 200 status code' do
      user = Fabricate(:user)
      session[:user_id] = user.id
      another_user = Fabricate(:user)
      relationship = Fabricate(:relationship, follower_id: user.id, leader_id: another_user.id)
      expect(response).to have_http_status(200)
    end
  end
end
