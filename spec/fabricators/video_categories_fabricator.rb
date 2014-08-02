
Fabricator(:video_category) do
  video_id { Fabricate(:video).id }
  category_id { Fabricate(:category).id }
end
