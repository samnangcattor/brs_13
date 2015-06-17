class CreateBookCategories < ActiveRecord::Migration
  def change
    create_table :book_categories do |t|
      t.references :book, index: true
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :book_categories, :categories
    add_foreign_key :book_categories, :books
  end
end
