
require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe 'GET #index' do

    it 'sets the @categories instance variable' do
      category_1 = Fabricate(:category)
      category_2 = Fabricate(:category)

      get :index
      expect(assigns(:categories)).to match_array([category_1, category_2])
    end

    it 'renders the categories/index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'responds successfully' do
      get :index
      expect(response).to be_success
    end

    it 'responds with an HTTP 200 status code' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do

    it 'sets the @category instance variable' do
      category = Fabricate(:category)

      get :show, id: category.id
      expect(assigns(:category)).to eq(category)
    end
  end
end
