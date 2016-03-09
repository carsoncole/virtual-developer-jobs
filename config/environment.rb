# Load the Rails application.
require File.expand_path('../application', __FILE__)

AUTHENTICATION = Rails.application.config_for :passwords

ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'gmail.com',
    :user_name            => AUTHENTICATION["GMAIL_USERNAME"],
    :password             => AUTHENTICATION["GMAIL_PASSWORD"],
    :authentication       => 'plain',
    :enable_starttls_auto  => true
}

# Initialize the Rails application.
Rails.application.initialize!
