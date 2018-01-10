class ChangeTypeOfInteractive < ActiveRecord::Migration[5.0]
  def change
    change_column :user_events, :like, :boolean
    change_column :user_events, :join, :boolean
  end
end
