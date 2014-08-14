
require 'rails_helper'

include SessionSteps
include MyQueueFeatureSetup

RSpec.feature 'saving videos to my queue', type: :feature do

  before { my_queue_general_setup }

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

  scenario 'user adds the video to the queue' do
    visit video_path(@video_1)

    find("a[href='/queue_items?video_id=#{@video_1.id}']").click

    expect(current_path).to eq(my_queue_path)
    expect(page).to have_content ("You added #{@video_1.title} to your queue.")

    visit video_path(@video_1)

    expect(page).not_to have_content ("+ My Queue")
  end

  scenario 'user returns to the home page' do
    visit my_queue_path

    find("a[href='/home']").click

    expect(current_path).to eq(home_path)
    expect(page).to have_content @category.name
  end

  scenario 'user selects a second video' do
    visit home_path

    find("a[href='/videos/#{@video_2.id}']").click

    expect(current_path).to eq(video_path(@video_2))
    expect(page).to have_content @video_2.title
    expect(page).to have_content @video_2.description
  end

  scenario 'user adds the video to the queue' do
    visit video_path(@video_2)

    find("a[href='/queue_items?video_id=#{@video_2.id}']").click

    expect(current_path).to eq(my_queue_path)
    expect(page).to have_content ("You added #{@video_2.title} to your queue.")
  end
end

RSpec.feature 'reordering videos in my queue', type: :feature do

  before { my_queue_queue_item_setup }

  scenario 'user changes the queue item list order' do
    visit my_queue_path

    fill_in 'video_1', with: 3
    fill_in 'video_2', with: 1
    fill_in 'video_3', with: 2

    click_button 'Update Instant Queue'

    expect(@queue_item_2.reload.list_order).to eq(1)
    expect(@queue_item_3.reload.list_order).to eq(2)
    expect(@queue_item_1.reload.list_order).to eq(3)

    # EXPECTATIONS AS PER SOLUTION VIDEO
    expect(find('#video_2').value).to eq('1')
    expect(find('#video_3').value).to eq('2')
    expect(find('#video_1').value).to eq('3')
  end

  # USING DATA ATTRIBUTE AS PER SOLUTION VIDEO
  scenario 'user changes the queue item list order' do
    visit my_queue_path

    find("input[data-video-id='#{@queue_item_1.video.id}']").set(3)
    find("input[data-video-id='#{@queue_item_2.video.id}']").set(1)
    find("input[data-video-id='#{@queue_item_3.video.id}']").set(2)

    click_button 'Update Instant Queue'

    expect(find("input[data-video-id='#{@queue_item_2.video.id}']").value).to eq('1')
    expect(find("input[data-video-id='#{@queue_item_3.video.id}']").value).to eq('2')
    expect(find("input[data-video-id='#{@queue_item_1.video.id}']").value).to eq('3')
  end

  # USING XPATH AS PER SOLUTION VIDEO
  scenario 'user changes the queue item list order' do
    visit my_queue_path

    within(:xpath, "//tr[contains(.,'#{@queue_item_1.video.title}')]") do
      fill_in 'queue_items[][list_order]', with: 3
    end

    within(:xpath, "//tr[contains(.,'#{@queue_item_2.video.title}')]") do
      fill_in 'queue_items[][list_order]', with: 1
    end

    within(:xpath, "//tr[contains(.,'#{@queue_item_3.video.title}')]") do
      fill_in 'queue_items[][list_order]', with: 2
    end

    click_button 'Update Instant Queue'

    expect(find(:xpath, "//tr[contains(.,'#{@queue_item_2.video.title}')]//input[@type='text']").value).to eq('1')
    expect(find(:xpath, "//tr[contains(.,'#{@queue_item_3.video.title}')]//input[@type='text']").value).to eq('2')
    expect(find(:xpath, "//tr[contains(.,'#{@queue_item_1.video.title}')]//input[@type='text']").value).to eq('3')
  end

  # USING REFACTORED XPATH AS PER SOLUTION VIDEO
  scenario 'user changes the queue item list order' do
    visit my_queue_path

    set_video_position(@queue_item_1.video, 3)
    set_video_position(@queue_item_2.video, 1)
    set_video_position(@queue_item_3.video, 2)

    click_button 'Update Instant Queue'

    expect_video_position(@queue_item_2.video, 1)
    expect_video_position(@queue_item_3.video, 2)
    expect_video_position(@queue_item_1.video, 3)
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in 'queue_items[][list_order]', with: position
    end
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end
end
