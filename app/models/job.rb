class Job < ActiveRecord::Base
  acts_as_taggable_on :skills

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one :payment
  after_save :send_your_job_has_been_posted_notification!, if: Proc.new {|job| job.published_at_changed? && job.published_at > Time.now - 20.minutes}
  after_save :set_initial_rank!, if: Proc.new {|job| job.published_at_changed? && job.published_at > Time.now - 20.minutes}
  after_save :send_new_job_posted_notification!, if: Proc.new {|job| job.published_at_changed? && job.published_at > Time.now - 20.minutes}
  validates :company_name, :title, :company_email, :description, :how_to_apply, presence: true
  validates :company_name, length: { maximum: 40 }
  validates :title, length: { maximum: 50 }

  after_save :tweet, if: Proc.new { |j| j.published_at_changed? && j.published_at != nil && j.tweet_id.nil? }

  def tweet
    return if self.tweeted_at # don't allow retweets

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = AUTHENTICATION["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = AUTHENTICATION["TWITTER_CONSUMER_SECRET"]
      config.access_token        = AUTHENTICATION["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = AUTHENTICATION["TWITTER_ACCESS_TOKEN_SECRET"]
    end

    # Compose Twitter Message
    title = "Remote Job: #{self.title}"
    
    if self.employer_twitter_account.blank?
      company = " @ #{self.company_name.gsub(".com","").gsub(".co", "").gsub(".org","").gsub(".net","")}" # remove any .com/.org/.net so it does not become a link
    else
      company = ' ' + self.employer_twitter_account
    end

    skills = " Skills: "
    link = " https://virtualdeveloperjobs.com/jobs/#{self.slug||self.id}"

    message = title + company

    hashtags = []
    if self.skill_list.include? "Ruby on Rails"
      hashtags << " #RubyOnRails"
    end
    if hashtags.any?
      message += hashtags.join(", ")
      message += ' '
    end

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

    # Add addition hashtags if space permitting
    if message.size < 105
      message += " #remotejob"
    end

    message += link


    # Tweet!
    t = client.update(message)
    self.update(tweeted_at: Time.now, tweet_id: t.id.to_s)
    return t
  end

  def self.tweet_left(delay_time)
    jos = Job.where(tweeted_at: nil) 
    jos.each do |job|
      puts "Tweeting Job: " + job.id.to_s + ' - ' + job.title
      begin
        job.tweet
      rescue
        puts '***FAIL on job:' + job.id.to_s
      end
      time = 100 + (Random.rand(delay_time).minutes) 
      puts "----WAITING Time: " + time.to_s
      sleep time
    end
  end


  def self.published
    where("published_at > ?", Date.today - Ranker::JOB_DURATION)
  end

  private

  def set_initial_rank!
    self.update(rank: Rankers::JOB_DURATION)
  end

  def send_new_job_posted_notification!
    NotificationMailer.new_job_posted(self.id).deliver_now
  end

  def send_your_job_has_been_posted_notification!
    NotificationMailer.your_job_has_been_posted(self.id).deliver_now
  end
end