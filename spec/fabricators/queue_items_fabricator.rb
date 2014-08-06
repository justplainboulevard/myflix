
Fabricator(:queue_item) do
  video_id { Fabricate(:video).id }
  user_id { Fabricate(:user).id }
end
