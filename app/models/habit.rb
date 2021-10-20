class Habit < ApplicationRecord
  has_many :habit_checkins
  has_many :checkins, through: :habit_checkins
  has_many :users, through: :checkins
  has_many :goals

  validates :name, presence: true, uniqueness: true

  def oldest_checkin_for_user(user)
    checkins.where(user: user).order(:date).limit(1).first
  end
end
