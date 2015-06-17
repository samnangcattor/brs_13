class CreateAuthorBooks < ActiveRecord::Migration
  def change
    create_table :author_books do |t|
      t.references :book, index: true
      t.references :author, index: true

      t.timestamps null: false
    end
    add_foreign_key :author_books, :books
    add_foreign_key :author_books, :authors
  end
end
