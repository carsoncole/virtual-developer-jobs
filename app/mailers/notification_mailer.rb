class NotificationMailer < ActionMailer::Base
  default :from => "\"Virtual Dev Jobs\" <VirtualDeveloperJobs@gmail.com>"

  def create(notification_id)
    @notification= Notification.find(notification_id)
    mail(to: @notification.email, subject: "You are signed up for job notifications")
  end

end