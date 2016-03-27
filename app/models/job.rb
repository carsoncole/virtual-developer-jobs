class Job < ActiveRecord::Base
  acts_as_taggable_on :skills

  extend FriendlyId
  friendly_id :title, use: :slugged

  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "9toVcVi3psNtey25Q5AhVa1xc"
    config.consumer_secret     = "pk1yqr92lKDkKkzGkybTGL8xRGm9sFxZAV9hk2ypdfwZ5g9vaT"
    config.access_token        = "706899029683077120-q6h49QJFolnJt264c9gdIqTADl8dId6"
    config.access_token_secret = "Ust0wlg0TvWS1T1hXnPgJbyOaf7QuV45oLAtRGuUkgD6b"
  end


  has_one :payment
  after_save :send_your_job_has_been_posted_notification!, if: Proc.new {|job| job.published_at_changed? && job.published_at > Time.now - 20.minutes}
  after_save :send_new_job_posted_notification!, if: Proc.new {|job| job.published_at_changed? && job.published_at > Time.now - 20.minutes}
  validates :company_name, :title, :company_email, :description, :how_to_apply, presence: true
  validates :company_name, length: { maximum: 45 }
  validates :title, length: { maximum: 60 }

  after_save :tweet, if: Proc.new {|j| j.published_at_changed? && j.published_at != nil}

  def tweet
    client.update("New job: #{self.title}. Skills sought: #{self.skill_list.join(',')}. See https://virtualdeveloperjobs.com/#{job.slug}")
  end

  private

  def send_new_job_posted_notification!
    NotificationMailer.new_job_posted(self.id).deliver_now
  end

  def send_your_job_has_been_posted_notification!
    NotificationMailer.your_job_has_been_posted(self.id).deliver_now
  end
end