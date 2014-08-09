
Fabricator(:queue_item) do
  video_id { Fabricate(:video).id }
  user_id { Fabricate(:user).id }
  list_order { [1, 2, 3].sample }
end
