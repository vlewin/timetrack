Fabricator(:user) do
  username { Faker::Internet.user_name }
  email { Faker::Internet.email }
  password "password"

  timetracks(count: 3) { Fabricate.build(:timetrack, user: nil) }
end
