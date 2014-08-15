Fabricator(:timetrack) do
  date { sequence(:date) { |i| i.days.ago } }
  start { Time.now }
  finish { 8.hours.from_now }

  user
end
