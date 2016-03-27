class Job < ActiveRecord::Base
  acts_as_taggable_on :skills

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one :payment
  after_save :send_your_job_has_been_posted_notification!, if: Proc.new {|job| job.published_at_changed? && job.published_at > Time.now - 20.minutes}
  after_save :send_new_job_posted_notification!, if: Proc.new {|job| job.published_at_changed? && job.published_at > Time.now - 20.minutes}
  validates :company_name, :title, :company_email, :description, :how_to_apply, presence: true
  validates :company_name, length: { maximum: 45 }
  validates :title, length: { maximum: 60 }

  #after_save :tweet, if: Proc.new { |j| j.published_at_changed? && j.published_at != nil }

  def tweet
    return if self.tweeted_at # don't allow retweets

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "9toVcVi3psNtey25Q5AhVa1xc"
      config.consumer_secret     = "pk1yqr92lKDkKkzGkybTGL8xRGm9sFxZAV9hk2ypdfwZ5g9vaT"
      config.access_token        = "706899029683077120-q6h49QJFolnJt264c9gdIqTADl8dId6"
      config.access_token_secret = "Ust0wlg0TvWS1T1hXnPgJbyOaf7QuV45oLAtRGuUkgD6b"
    end

    title = "New job: #{self.title}"
    company = " at #{self.company_name}"
    skills = " Skills sought: "
    link = " https://virtualdeveloperjobs.com/#{self.slug||self.id}"

    message = title + company

    self.skill_list.each do |skill|
      if (message + skills + skill + ', ').size < 116
        if skill == self.skill_list.first
          skills += skill
        else
          skills += ', ' + skill
        end
      else
        break
      end
    end

    message += skills unless skills.blank?

    message += link

    t = client.update(message)

    self.update(tweeted_at: Time.now, tweet_id: t.id)
  end

  def self.tweet_left
    jos = Job.where(tweeted_at: nil) 
    jos.each do |job|
      puts "Tweeting Job: " + job.id.to_s + ' - ' + job.title
      begin
        job.tweet
      rescue
        puts '***FAIL on job:' + job.id.to_s
      end
      time = 100 + (Random.rand(20).minutes) 
      puts "----WAITING Time: " + time.to_s
      sleep time
    end
  end


  private

  def send_new_job_posted_notification!
    NotificationMailer.new_job_posted(self.id).deliver_now
  end

  def send_your_job_has_been_posted_notification!
    NotificationMailer.your_job_has_been_posted(self.id).deliver_now
  end
end