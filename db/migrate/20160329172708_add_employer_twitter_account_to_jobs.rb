class AddEmployerTwitterAccountToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :employer_twitter_account, :string
  end
end
