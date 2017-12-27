class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.datetime :date_start
      t.datetime :date_end
      t.boolean :is_open
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
