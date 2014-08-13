
require 'rails_helper'

include SessionSteps
include VideoSteps

RSpec.feature 'my queue', type: :feature do



  scenario 'user signs in' do
    sign_in(user)
    expect(page).to have_content 'You are now signed in'
  end

  scenario 'user selects a video' do
    find_video(video)
    expect(page).to have_content video.title
    expect(page).to have_content video.description
  end
end
