# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'us@angela-ryan.rsvp'
  layout 'mailer'
end
