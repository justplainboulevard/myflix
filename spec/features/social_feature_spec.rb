
require 'rails_helper'

include SessionSteps
include FollowUserFeatureSetup

RSpec.feature 'following other users', type: :feature do

  before { follow_user_general_setup }

  scenario 'user signs in' do

    expect(current_path).to eq(home_path)
    expect(page).to have_content 'You are now signed in'
  end

  scenario 'user selects a video' do
    visit home_path

    find("a[href='/videos/#{@video_1.id}']").click

    expect(current_path).to eq(video_path(@video_1))
    expect(page).to have_content @video_1.title
    expect(page).to have_content @video_1.description
  end

  scenario 'user selects the author of a video review' do
    visit video_path(@video_1)

    find("a[href='/users/#{@users[2].id}']").click

    expect(current_path).to eq(user_path(@users[2]))
    expect(page).to have_content @users[2].full_name
  end

  scenario 'user follows another user' do
    visit user_path(@users[2])

    find("a[href='/relationships?leader_id=#{@users[2].id}']").click

    expect(current_path).to eq(people_path)
    expect(page).to have_content @users[2].full_name
  end

  scenario 'user unfollows another user' do
    visit user_path(@users[2])

    find("a[href='/relationships?leader_id=#{@users[2].id}']").click

    find("a[data-method='delete']").click

    expect(current_path).to eq(people_path)
    expect(page).to have_content "You are no longer following #{@users[2].full_name}"
  end
end