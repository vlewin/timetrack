class User < ActiveRecord::Base
  devise :database_authenticatable, :validatable, :registerable
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  attr_accessible :login
  attr_accessor :login # Virtual attribute for authenticating by either username or email

  has_many :timetracks

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
