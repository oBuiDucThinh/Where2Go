class RemoveJoinColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :like_events, :join
  end
end
