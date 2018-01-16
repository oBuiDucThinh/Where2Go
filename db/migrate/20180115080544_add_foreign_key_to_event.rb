class AddForeignKeyToEvent < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :events, :user_id
  end
end
