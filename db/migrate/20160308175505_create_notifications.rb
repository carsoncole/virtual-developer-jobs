class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :email, null: false

      t.timestamps null: false
    end
  end
end
