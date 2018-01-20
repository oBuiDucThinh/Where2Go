class AddIndexToJoinTable < ActiveRecord::Migration[5.0]
  def change
    add_index :join_events, :user_id
    add_index :join_events, :event_id
  end
end
