class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, index: true
      t.integer :target_id
      t.string :state_target

      t.timestamps null: false
    end
    add_foreign_key :activities, :users
  end
end
