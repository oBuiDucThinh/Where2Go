class ChangeDateStartToDateInEvents < ActiveRecord::Migration[5.0]
  def change
    change_column :events, :date_start, :date
    change_column :events, :date_end, :date
  end
end
