class User
  include Mongoid::Document
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :case_sensitive => false

  attr_accessible :username, :email, :password, :password_confirmation

  ## Database authenticatable
  field :username, :type => String
  field :email, :type => String
  field :encrypted_password, :type => String

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  embeds_many :timetracks do

#    def chinese
#      @target.select { |address| address.country == "China"}
#    end
  end
end
