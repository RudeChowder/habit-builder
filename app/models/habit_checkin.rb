class HabitCheckin < ApplicationRecord
  belongs_to :habit
  belongs_to :checkin
end
