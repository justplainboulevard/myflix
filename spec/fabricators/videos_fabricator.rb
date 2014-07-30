
Fabricator(:video) do
  title { Faker::Lorem.sentence(3) }
  description { Faker::Lorem.paragraph(5) }
end
