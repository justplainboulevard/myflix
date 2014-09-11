
require 'rails_helper'

RSpec.shared_examples 'is tokenable' do

  it 'generates a random token' do
    expect(object.token).to be_present
  end
end
