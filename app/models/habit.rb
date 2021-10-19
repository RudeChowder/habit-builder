class Habit < ApplicationRecord
  has_many :checkins
  has_many :users, through: :checkins
end