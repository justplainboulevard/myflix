
Fabricator(:user) do
  email_address { Faker::Internet.email }
  password { Faker::Lorem.characters(10) }
  full_name { Faker::Name.name }
end
