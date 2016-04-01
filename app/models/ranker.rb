# This class ranks each job by its appeal. It should be run on a schedule (CRON).
class Ranker
  
  JOB_DURATION = 30 # days

  def self.run
    Job.published.all.each do |job|
      days_left = ( job.published_at + JOB_DURATION.days - Time.now ) / (24 * 60 * 60)
      if job.rank && job.rank > 0
        job.update( rank:  job.rank - (job.rank / days_left.to_i) )
      end
    end
  end



end