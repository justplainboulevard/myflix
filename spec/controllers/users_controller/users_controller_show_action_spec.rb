
require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #show' do

    it_behaves_like 'requires user' do
      let(:action) { get :show, id: Fabricate(:user).id }
    end

    set_user

    before :each do
      set_current_user
      get :show, id: user.id
    end

    it 'sets the @user instance variable' do
      expect(assigns(:user)).to eq(user)
    end
  end
end
