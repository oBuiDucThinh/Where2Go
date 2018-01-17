class AddCountToTable < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :like_count, :integer
    add_column :events, :join_count, :integer
  end
end
