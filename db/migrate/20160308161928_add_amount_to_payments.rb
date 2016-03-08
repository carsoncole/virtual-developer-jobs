class AddAmountToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :amount,:decimal, :null => :false, :default => 0, :precision => 8, :scale => 2
    add_column :payments, :is_paid_in_full, :boolean, :null => :false, :default => 0, :precision => 8, :scale => 2
    add_column :payments, :job_id, :integer
  end
end
