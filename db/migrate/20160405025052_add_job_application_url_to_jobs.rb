class AddJobApplicationUrlToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :job_application_url, :string
  end
end
