class NotificationMailer < ActionMailer::Base
  default :from => "\"Virtual Dev Jobs\" <VirtualDevelopmentJobs@gmail.com>"

  def create(notification_id)
    @notification= Notification.find(notification_id)
    mail(to: @notification.email, subject: "You are signed up for job notifications")
  end

  def new_job(job_id)
    @job = Job.find(job_id)
    Notification.all.each do |notification|
      mail(to: notification.email, subject: "NEW virtual job: #{@job.title}")
    end
  end

end