Fabricator(:timetrack) do
  date { sequence(:date) { |i| i.days.ago } }
  start { Time.at('8:00'.to_time) }
  finish { Time.at('17:00'.to_time) }

  user
end
