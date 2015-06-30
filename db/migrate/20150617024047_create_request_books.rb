class CreateRequestBooks < ActiveRecord::Migration
  def change
    create_table :request_books do |t|
      t.references :user, index: true
      t.string :name
      t.string :description
      t.boolean :state, default: false

      t.timestamps null: false
    end
    add_foreign_key :request_books, :users
  end
end
