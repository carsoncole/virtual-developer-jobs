class AddEmployerCareersUrlToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :employer_careers_url, :string
    add_column :jobs, :job_url, :string
  end
end
