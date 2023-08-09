# frozen_string_literal: true

class ExceptionMailer < ApplicationMailer
  def send_alert(exception, request)
    @exception = exception
    @request = request
    subject = "[RSVP Exception] #{exception.message}"
    mail(to: distribution_list, subject: subject)
  end

  private

  def distribution_list
    %w[rtulino@gmail.com]
  end
end
