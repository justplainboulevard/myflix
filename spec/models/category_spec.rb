
require 'rails_helper'

RSpec.describe Category, type: :model do

  it 'saves itself' do
    new_category = Category.new(name: 'My Category')
    new_category.save

    saved_category = Category.first
    expect(saved_category.name).to eq('My Category')
  end

  it 'has many videos' do
    another_category = Category.create(name: 'Another Category')
    video_one = Video.create(title: 'ZZZ Video', description: 'ZZZ video description.')
    video_two = Video.create(title: 'AAA Video', description: 'AAA video description.')
    video_category_one = VideoCategory.create(category_id: another_category.id, video_id: video_one.id)
    video_category_two = VideoCategory.create(category_id: another_category.id, video_id: video_two.id)

    expect(another_category.videos).to eq([video_two, video_one])
  end
end
