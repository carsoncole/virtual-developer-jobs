class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount, :null => :false, :default => 0, :precision => 8, :scale => 2
      t.boolean :is_paid_in_full, :null => :false, :default => 0, :precision => 8, :scale => 2
      t.integer :job_id
      t.timestamps null: false
    end
  end
end