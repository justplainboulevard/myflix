
Fabricator(:review) do
  video_id { Fabricate(:video).id }
  user_id { Fabricate(:user).id }
  body { Faker::Lorem.paragraph(5) }
  rating { %w(5, 4, 3, 2, 1).sample.to_i }
end
