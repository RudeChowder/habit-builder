class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :habit
  accepts_nested_attributes_for :habit, reject_if: :all_blank

  validates :target, presence: true, numericality: { greater_than: 0 }
end
