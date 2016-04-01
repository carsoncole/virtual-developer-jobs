class AddRankToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :rank, :integer
  end
end
