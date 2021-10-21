class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :habit
  accepts_nested_attributes_for :habit, reject_if: :all_blank

  validates :target, presence: true, numericality: { greater_than: 0 }

  scope :achieved, -> { where(achieved: true) }
  scope :unachieved, -> { where(achieved: false) }

  def check_completion
    prior_value = achieved
    self.achieved = user.checkin_count_for_habit(habit) >= target
    save unless achieved == prior_value
  end
end
