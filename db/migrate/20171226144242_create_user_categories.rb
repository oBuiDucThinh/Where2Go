class CreateUserCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :user_categories do |t|
      t.interger :user_id
      t.interger :category_id

      t.timestamps
    end
  end
end
