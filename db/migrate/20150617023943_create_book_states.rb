class CreateBookStates < ActiveRecord::Migration
  def change
    create_table :book_states do |t|
      t.references :book, index: true
      t.references :user, index: true
      t.string :state, default: "unread"
      t.boolean :favorite, default: false

      t.timestamps null: false
    end
    add_foreign_key :book_states, :books
    add_foreign_key :book_states, :users
  end
end
