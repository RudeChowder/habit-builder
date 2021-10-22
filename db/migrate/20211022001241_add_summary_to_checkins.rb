class AddSummaryToCheckins < ActiveRecord::Migration[6.1]
  def change
    add_column :checkins, :summary, :string
  end
end
