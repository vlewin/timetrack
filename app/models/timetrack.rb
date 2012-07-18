class Timetrack
  include Mongoid::Document

  attr_accessible :username, :email, :password, :password_confirmation

  field :date, :type => Date
  field :start, :type => Time
  field :finish, :type => Time
  field :duration,   :type => Float
  field :user_id, :type => Integer
end
