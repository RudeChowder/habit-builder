class CreateHabitCheckins < ActiveRecord::Migration[6.1]
  def change
    create_table :habit_checkins do |t|
      t.integer :habit_id
      t.integer :checkin_id

      t.timestamps
    end
  end
end
