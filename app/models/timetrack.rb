class Timetrack
  include Mongoid::Document

#  attr_accessible :date, :start, :finish, :duration, :user_id
  field :date, :type => Date
  field :start, :type => Time
  field :finish, :type => Time
  field :duration,   :type => Float
  embedded_in :user
end
