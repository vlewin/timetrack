class User < ActiveRecord::Base
  devise :database_authenticatable, :validatable, :registerable

  # Virtual attribute for authenticating by either username or email
  attr_accessor :login

  validates_uniqueness_of :username

  has_many :timetracks

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def balance(abbr= :short)
    self.timetracks.to_a.sum(&:balance).to_time(abbr)
  end

end
