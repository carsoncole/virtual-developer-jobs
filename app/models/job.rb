class Job < ActiveRecord::Base
  acts_as_taggable_on :skills
  has_one :payment
  after_save :send_your_job_has_been_posted_notification!, if: Proc.new {|job| job.published_at_changed? && job.published_at > Time.now - 20.minutes}
  after_save :send_new_job_posted_notification!, if: Proc.new {|job| job.published_at_changed? && job.published_at > Time.now - 20.minutes}
  validates :company_name, :title, :company_email, :description, :how_to_apply, presence: true
  validates :company_name, length: { maximum: 45 }
  validates :title, length: { maximum: 60 }

  private

  def send_new_job_posted_notification!
    NotificationMailer.new_job_posted(self.id).deliver_now
  end

  def send_your_job_has_been_posted_notification!
    NotificationMailer.your_job_has_been_posted(self.id).deliver_now
  end
end