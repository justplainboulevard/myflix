
require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe 'GET #show' do

    set_category

    it_behaves_like 'requires user' do
      let(:action) { get :show, id: category.id }
    end

    before :each do
      set_current_user
      get :show, id: category.id
    end

    it 'sets the @category instance variable' do
      expect(assigns(:category)).to eq(category)
    end

    it 'renders the categories/show template' do
      expect(response).to render_template :show
    end

    it 'responds successfully' do
      expect(response).to be_success
    end

    it 'responds with an HTTP 200 status code' do
      expect(response).to have_http_status(200)
    end
  end
end
