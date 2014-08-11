
def set_user
  let(:user) { Fabricate(:user) }
end

def set_current_user(user=nil)
 session[:user_id] = (user || Fabricate(:user).id)
end

def clear_current_user
 session[:user_id] = nil
end

def current_user
 User.find(session[:user_id])
end

def set_video
  let(:video) { Fabricate(:video) do
    reviews { 3.times.map { Fabricate(:review) } }
  end }
end

def set_videos
  let(:videos) { Fabricate.times(7, :video) }
end

def set_queue_item
  let(:queue_item) { Fabricate(:queue_item, user_id: user.id, video_id: video.id) }
end

def set_category
  let(:category) { Fabricate(:category) }
end

def set_categories
  let(:categories) { Fabricate.times(3, :category) }
end
