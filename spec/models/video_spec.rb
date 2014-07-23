# == Schema Information
#
# Table name: videos
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  description      :text
#  poster_small_url :string(255)
#  poster_large_url :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#


require 'rails_helper'

RSpec.describe Video, type: :model do

  it 'saves itself' do
    new_video = Video.new(title: 'My Video Title', description: 'My lengthy video description.', poster_small_url: 'my_small_cover_url.jpg', poster_large_url: 'my_large_cover_url.jpg')
    new_video.save

    saved_video = Video.first
    expect(saved_video.title).to eq('My Video Title')
    expect(saved_video.description).to eq('My lengthy video description.')
    expect(saved_video.poster_small_url).to eq('my_small_cover_url.jpg')
    expect(saved_video.poster_large_url).to eq('my_large_cover_url.jpg')
  end

  it 'has many categories' do
    another_video = Video.create(title: 'Another Video Title', description: 'Another lengthy video description.', poster_small_url: 'another_small_cover_url.jpg', poster_large_url: 'another_large_cover_url.jpg')
    category_one = Category.create(name: 'ZZZ')
    category_two = Category.create(name: 'AAA')
    video_category_one = VideoCategory.create(category_id: category_one.id, video_id: another_video.id)
    video_category_two = VideoCategory.create(category_id: category_two.id, video_id: another_video.id)

    expect(another_video.categories).to eq([category_two, category_one])
  end

  it 'does not save without a title' do
    video = Video.create(description: 'Video description!')

    expect(Video.count).to eq(0)
  end

  it 'does not save without a description' do
    video = Video.create(title: 'Video Title')

    expect(Video.count).to eq(0)
  end
end
