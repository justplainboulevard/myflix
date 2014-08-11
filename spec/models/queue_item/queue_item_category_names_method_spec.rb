
require 'rails_helper'

RSpec.describe QueueItem, type: :model do

  # describe '#category_names' do

  #   let(:video) { Fabricate(:video) }
  #   set_user

  #   it 'it returns an array of the category names for the video' do

  #     new_categories = Fabricate.times(2, :category)
  #     new_categories.each do |category|
  #       Fabricate(:video_category, video_id: video.id, category_id: category.id)
  #     end
  #     names = []
  #     video.categories.each do |category|
  #       names << category.name
  #     end
  #     queue_item = Fabricate(:queue_item, user_id: user.id, video_id: video.id)

  #     expect(queue_item.category_names).to match_array(names)
  #   end
  # end
end
