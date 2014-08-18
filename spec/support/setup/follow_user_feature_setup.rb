
module FollowUserFeatureSetup

  def follow_user_general_setup

    @users = Fabricate.times(6, :user)
    @videos = Fabricate.times(6, :video)
    @category = Fabricate(:category)
    @videos.each do |video|
      Fabricate(:video_category, video_id: video.id, category_id: @category.id)
      @users.each do |user|
        Fabricate(:review, video_id: video.id, user_id: user.id)
      end
    end
    @video_1 = Video.find(1)
    @video_2 = Video.find(2)
    @video_3 = Video.find(3)
    sign_in(@users[0])
  end

  def sign_in(user)

    ensure_on signin_path
    fill_in 'Email address', with: user.email_address
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end
end
