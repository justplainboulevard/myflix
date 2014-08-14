# DOES NOT WORK; DOES NOT SEE METHODS

# require 'rails_helper'

# # TOTALLY REFACTORED IN ACCORDANCE WITH SOLUTION VIDEO

# # KEY TAKEAWAYS: MAKE THE FEATURE SPECS READ AS EASILY AS POSSIBLE TO TRACK USER INTERACTION; KEEP A CONSISTENT LEVEL OF ABSTRACTION

# RSpec.feature 'my queue', type: :feature do

#   my_queue_setup

#   sign_in(@user)
#   expect_user_is_signed_in

#   select_video(@video_1)
#   expect_user_to_see_show_page(@video_1)

#   add_video_to_queue(@video_1)
#   expect_video_is_added_to_queue(@video_1)

#   return_to_video_show_page(@video_1)
#   expect_user_not_to_see_add_to_queue_button

#   add_video_to_queue(@video_2)
#   add_video_to_queue(@video_3)

#   visit my_queue_path

#   set_video_position(@video_1, 3)
#   set_video_position(@video_2, 1)
#   set_video_position(@video_3, 2)

#   click_button 'Update Instant Queue'

#   expect_video_position(@video_2, 1)
#   expect_video_position(@video_3, 2)
#   expect_video_position(@video_1, 3)

#   def my_queue_setup
#     @user = Fabricate(:user)
#     @videos = Fabricate.times(6, :video)
#     @category = Fabricate(:category)
#     @videos.each do |video|
#       Fabricate(:video_category, video_id: video.id, category_id: @category.id)
#     end
#     @video_1 = Video.find(1)
#     @video_2 = Video.find(2)
#     @video_3 = Video.find(3)
#   end

#   def sign_in(user)
#     visit '/signin'
#     fill_in 'Email address', with: user.email_address
#     fill_in 'Password', with: user.password
#     click_button 'Sign In'
#   end

#   def expect_user_is_signed_in
#     expect(current_path).to eq(home_path)
#     expect(page).to have_content 'You are now signed in'
#   end

#   def select_video(video)
#     visit home_path
#     find("a[href='/videos/#{video.id}']").click
#   end

#   def expect_user_to_see_show_page(video)
#     expect(current_path).to eq(video_path(video))
#     expect(page).to have_content video.title
#     expect(page).to have_content video.description
#   end

#   def add_video_to_queue(video)
#     visit video_path(video)
#     find("a[href='/queue_items?video_id=#{video.id}']").click
#   end

#   def expect_video_is_added_to_queue(video)
#     expect(current_path).to eq(my_queue_path)
#     expect(page).to have_content ("You added #{video.title} to your queue.")
#   end

#   def return_to_video_show_page(video)
#     visit video_path(video)
#   end

#   def expect_user_not_to_see_add_to_queue_button
#     expect(page).not_to have_content ("+ My Queue")
#   end

#   def set_video_position(video, position)
#     within(:xpath, "//tr[contains(.,'#{video.title}')]") do
#       fill_in 'queue_items[][list_order]', with: position
#     end
#   end

#   def expect_video_position(video, position)
#     expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
#   end
# end
