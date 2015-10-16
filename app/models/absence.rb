class Absence < ActiveRecord::Base
  enum reason: [ :vacation, :holiday, :sickness ]

  validates :date, presence: true
  validates :user, presence: true
  validates :date, uniqueness: { scope: :user_id }

  belongs_to :user
end
