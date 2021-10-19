class Habit < ApplicationRecord
  has_many :habit_checkins
  has_many :checkins, through: :habit_checkins
  has_many :users, through: :checkins
end