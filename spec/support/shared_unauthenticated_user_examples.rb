
require 'rails_helper'

RSpec.shared_examples 'requires user' do

  before :each do
    clear_current_user
    action
  end

  it 'redirects the user to the root path' do
    expect(response).to redirect_to root_path
  end

  it 'responds with an HTTP 302 status code' do
    expect(response).to have_http_status(302)
  end
end
