
require 'rails_helper'

include SessionSteps

RSpec.feature 'my queue', type: :feature do

  scenario 'user signs in' do
    user = Fabricate(:user)
    sign_in(user)

    expect(page).to have_content 'You are now signed in'
  end

  scenario 'user selects a video' do
    user = Fabricate(:user)
    sign_in(user)
    videos = Fabricate.times(7, :video, poster_small_url: "/images/poster_small/captain-america-2-2014.jpg")
    category = Fabricate(:category)
    videos.each do |video|
      Fabricate(:video_category, video_id: video.id, category_id: category.id)
    end
    video = Video.first
    find("a[href='/videos/#{video.id}']").click

    expect(page).to have_content video.title
    expect(page).to have_content video.description
  end
end

