class CreateEventCities < ActiveRecord::Migration[5.0]
  def change
    create_table :event_cities do |t|
      t.references :event, foreign_key: true
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
