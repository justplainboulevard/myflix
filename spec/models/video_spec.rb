
require 'spec_helper'

RSpec.describe Video, type: :model do

  it "saves itself" do
    v = Video.new(title: 'My Video Title', description: 'My lengthy video description.', poster_small_url: 'my_small_cover_url.jpg', poster_large_url: 'my_large_cover_url.jpg')
    v.save

    expect(v.title).to eq('My Video Title')
    expect(v.description).to eq('My lengthy video description.')
    expect(v.poster_small_url).to eq('my_small_cover_url.jpg')
    expect(v.poster_large_url).to eq('my_large_cover_url.jpg')
  end
end
