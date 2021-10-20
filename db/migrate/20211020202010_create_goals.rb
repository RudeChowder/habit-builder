class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.integer :habit_id
      t.integer :target
      t.boolean :achieved, default: false

      t.timestamps
    end
  end
end
