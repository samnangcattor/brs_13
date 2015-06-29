class CreateBookFavorites < ActiveRecord::Migration
  def change
    create_table :book_favorites do |t|
      t.boolean :favorite
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
