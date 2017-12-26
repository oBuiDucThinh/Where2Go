class ChangeTableNameAgain < ActiveRecord::Migration[5.0]
  def change
    rename_table :interactives, :user_events
  end
end
