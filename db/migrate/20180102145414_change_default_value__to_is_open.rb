class ChangeDefaultValueToIsOpen < ActiveRecord::Migration[5.0]
  def change
    change_column_default :events, :is_open, true
  end
end
