class AddPaymentIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :payment_id, :integer
  end
end
