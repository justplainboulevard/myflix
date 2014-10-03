
require 'rails_helper'

RSpec.shared_examples 'requires admin' do

  before :each do
    set_current_user
    action
  end

  it 'redirects the user to the home path' do
    expect(response).to redirect_to home_path
  end

  it 'flashes a danger alert' do
    expect(flash[:danger]).to be_present
  end
end