# frozen_string_literal: true

return unless Rails.env.production?

ActionMailer::Base.smtp_settings = {
  user_name: 'apikey', # This is the string literal 'apikey', NOT the ID of your API key
  password: ENV.fetch('SENDGRID_API_KEY'),
  domain: 'angela-ryan.rsvp',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
