class Checkin < ApplicationRecord
  belongs_to :user
  has_many :habit_checkins
  has_many :habits, through: :habit_checkins
end