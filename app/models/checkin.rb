class Checkin < ApplicationRecord
  belongs_to :user
  has_many :habit_checkins
  has_many :habits, through: :habit_checkins
  accepts_nested_attributes_for :habits, reject_if: :all_blank

  validates :date, presence: true
  validate :date_not_in_the_future

  def date_not_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "cannot be in the future")
    end
  end
end