class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :date
      t.integer :page

      t.timestamps null: false
    end
  end
end
