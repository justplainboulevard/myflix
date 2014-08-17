
Fabricator(:relationship) do
  leader_id { Fabricate(:user).id }
  follower_id { Fabricate(:user).id }
end
