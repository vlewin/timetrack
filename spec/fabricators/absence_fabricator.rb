Fabricator(:absence, aliases: :vacation) do
  date { sequence(:date) {|i| i.days.ago } }
  reason 0
  user
end

Fabricator(:holiday, from: :absence) do
  reason 1
end

Fabricator(:sickness, from: :absence) do
  reason 2
end
