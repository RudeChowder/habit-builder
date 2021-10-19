class CreateCheckins < ActiveRecord::Migration[6.1]
  def change
    create_table :checkins do |t|
      t.integer :user_id, null: false
      t.integer :habit_id, null: false
      t.date :date, null: false
      t.text :notes

      t.timestamps
    end
  end
end
