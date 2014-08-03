
require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe 'GET #index' do

    let(:categories_list) { Fabricate.times(2, :category) }

    before { get :index }

    it 'sets the @categories instance variable' do
      expect(assigns(:categories)).to match_array(categories_list)
    end

    it 'renders the categories/index template' do
      expect(response).to render_template :index
    end

    it 'responds successfully' do
      expect(response).to be_success
    end

    it 'responds with an HTTP 200 status code' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do

    let(:category) { Fabricate(:category) }

    before { get :show, id: category.id }

    it 'sets the @category instance variable' do
      expect(assigns(:category)).to eq(category)
    end
  end
end
