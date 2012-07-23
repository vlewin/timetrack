class User
  include Mongoid::Document
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :authentication_keys => [:login]

  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :encrypted_password

  validates_uniqueness_of :username, :email, :case_sensitive => false

  attr_accessor :login
  attr_accessible :login, :username, :email, :password, :password_confirmation

  ## Database authenticatable
  field :username, :type => String
  field :email, :type => String
  field :encrypted_password, :type => String

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  index({ email: 1 }, { unique: true, background: true })

  embeds_many :timetracks

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ :username =>  /^#{Regexp.escape(login)}$/i }, { :email =>  /^#{Regexp.escape(login)}$/i } ).first
    else
      super
    end
  end

end
