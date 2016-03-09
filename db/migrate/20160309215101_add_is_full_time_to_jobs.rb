class AddIsFullTimeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :is_full_time, :boolean
  end
end
