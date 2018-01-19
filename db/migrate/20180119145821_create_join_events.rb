class CreateJoinEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :join_events do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
