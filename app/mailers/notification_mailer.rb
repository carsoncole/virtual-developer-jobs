class NotificationMailer < ActionMailer::Base
  default :from => "\"Virtual Dev Jobs\" <VirtualDevelopmentJobs@gmail.com>"

  def create(notification_id)
    @notification= Notification.find(notification_id)
    Rails.logger.fatal "ENV['GMAIL_PASSWORD'] = #{ENV['GMAIL_PASSWORD']}"
    Rails.logger.fatal "ENV['GMAIL_USERNAME'] = #{ENV['GMAIL_USERNAME']}"
    mail(to: @notification.email, subject: "You are signed up for job notifications")
  end

end