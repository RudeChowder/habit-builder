class CreateHabits < ActiveRecord::Migration[6.1]
  def change
    create_table :habits do |t|
      t.string :name, null: false
      t.string :image

      t.timestamps
    end
  end
end
