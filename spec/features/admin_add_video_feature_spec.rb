
require 'rails_helper'

RSpec.feature 'add video' do

  scenario 'admin user successfully adds a new video to the site' do

    admin_user = Fabricate(:admin)
    user = Fabricate(:user)
    Fabricate(:category, name: 'Musicals')

    visit signin_path
    fill_in 'Email address', with: admin_user.email_address
    fill_in 'Password', with: admin_user.password
    click_button 'Sign In'

    visit new_admin_video_path

    fill_in 'Title', with: 'The Sound of Music'
    select 'Musicals', from: 'Category ids'
    fill_in 'Description', with: 'A woman leaves an Austrian convent to become a governess to the children of a Naval officer widower.'
    attach_file 'Small cover', 'spec/support/uploads/sound_of_music.jpg'
    attach_file 'Large cover', 'spec/support/uploads/sound_of_music_large.png'
    fill_in 'Video URL', with: 'http://www.example.com/my_video.mp4'

    click_button 'Add Video'

    visit signout_path

    visit signin_path
    fill_in 'Email address', with: user.email_address
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit home_path
    expect(page).to have_selector("img[src='/uploads/display_sound_of_music.jpg']")

    visit video_path(Video.first)
    expect(page).to have_selector("a[href='http://www.example.com/my_video.mp4']")
  end
end
