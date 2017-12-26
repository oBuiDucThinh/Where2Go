class ChangeToLikeEventTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_events, :like
    rename_table :user_events, :like_events
  end
end
