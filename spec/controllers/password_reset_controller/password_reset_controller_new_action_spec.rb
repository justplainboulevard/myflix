
require 'rails_helper'

RSpec.describe PasswordResetController, type: :controller do

  describe 'GET #new' do

    before { get :new }

    it 'renders the password_reset/new template' do
      expect(response).to render_template :new
    end

    it 'responds successfully' do
      expect(response).to be_success
    end

    it 'responds with an HTTP 200 status code' do
      expect(response).to have_http_status(200)
    end
  end
end
