class Checkin < ApplicationRecord
  belongs_to :user
  has_many :habit_checkins
  has_many :habits, through: :habit_checkins
  accepts_nested_attributes_for :habits, reject_if: :all_blank

  validates :date, presence: true
  validate :date_not_in_the_future

  after_commit :update_goals

  def date_not_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "cannot be in the future")
    end
  end

  def pretty_date
    date.strftime("%a, %e %b %Y")
  end

  def update_goals
    habits.each do |habit|
      goals_to_update = user.goals.where(habit: habit)
      goals_to_update.each(&:check_completion)
    end
  end
end
