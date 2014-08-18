
require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do

  describe 'POST #create' do

    it_behaves_like 'requires user' do
      let(:action) { post :create, relationship: Fabricate.attributes_for(:relationship) }
    end

    context 'where the relationship does not already exist' do

      before :each do
        user = Fabricate(:user)
        session[:user_id] = user.id
        @another_user = Fabricate(:user)
        post :create, leader_id: @another_user.id
      end

      it 'creates a relationship in the database' do
        expect(current_user.follower_relationships.first.leader).to eq(@another_user)
      end

      it 'associates the @relationship instance variable with the current user' do
        expect(Relationship.first.follower).to eq(current_user)
      end

      it 'flashes a success alert' do
        expect(flash[:success]).not_to be_blank
      end

      it 'redirects the user to the people path' do
        expect(response).to redirect_to people_path
      end

      it 'responds with an HTTP 302 status code' do
        expect(response).to have_http_status(302)
      end
    end

    context 'where the relationship already exists' do

      before :each do
        user = Fabricate(:user)
        session[:user_id] = user.id
        another_user = Fabricate(:user)
        Fabricate(:relationship, follower_id: user.id, leader_id: another_user.id)
        post :create, leader_id: another_user.id
      end

      it 'does not create a relationship in the database' do
        expect(Relationship.count).to eq(1)
      end

      it 'flashes a success alert' do
        expect(flash[:success]).not_to be_blank
      end

      it 'redirects the user to the people path' do
        expect(response).to redirect_to people_path
      end

      it 'responds with an HTTP 302 status code' do
        expect(response).to have_http_status(302)
      end
    end

    it 'does not allow a user to follow himself or herself' do
      user = Fabricate(:user)
      session[:user_id] = user.id
      post :create, leader_id: user.id

      expect(Relationship.count).to eq(0)
    end
  end
end
