
require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  let(:categories) { Fabricate.times(2, :category) }

  describe 'GET #index' do

    before :each do
      get :index
    end

    it 'sets the @categories instance variable' do
      expect(assigns(:categories)).to match_array(categories)
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
end
