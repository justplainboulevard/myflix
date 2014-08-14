
module MyQueueFeatureSetup

  def my_queue_general_setup

    @user = Fabricate(:user)
    @videos = Fabricate.times(6, :video)
    @category = Fabricate(:category)
    @videos.each do |video|
      Fabricate(:video_category, video_id: video.id, category_id: @category.id)
    end
    @video_1 = Video.find(1)
    @video_2 = Video.find(2)
    @video_3 = Video.find(3)
    sign_in(@user)
  end

  def my_queue_queue_item_setup

    @user = Fabricate(:user)
    @videos = Fabricate.times(3, :video)
    @category = Fabricate(:category)
    @videos.each do |video|
      Fabricate(:video_category, video_id: video.id, category_id: @category.id)
      Fabricate(:review, video_id: video.id, user_id: @user.id)
    end
    @queue_item_1 = Fabricate(:queue_item, video_id: Video.find(1).id, user_id: @user.id)
    @queue_item_2 = Fabricate(:queue_item, video_id: Video.find(2).id, user_id: @user.id)
    @queue_item_3 = Fabricate(:queue_item, video_id: Video.find(3).id, user_id: @user.id)
    sign_in(@user)
  end
end
