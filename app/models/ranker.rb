# This class ranks each job by its appeal. It should be run on a schedule (CRON).
class Ranker
  
  JOB_DURATION = 30 # days

  def self.run
    Job.each do |job|
      days_left = JOB_DURATION - (Date.today - job.published_at)
      job.rank = job.rank - (job.rank / days_left)
    end
  end



end