
Fabricator(:invitation) do
  invitee_name { Faker::Name.name }
  invitee_email_address { Faker::Internet.email }
  invitation_message { Faker::Lorem.sentence }
end
