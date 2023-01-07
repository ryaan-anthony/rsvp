# frozen_string_literal: true

class GuestUpdateMailer < ApplicationMailer
  def send_alert(guest)
    @guest = guest
    subject = "RSVP Update from #{guest.first_name} #{guest.last_name}"
    mail(to: distribution_list, subject: subject)
  end

  private

  def distribution_list
    %w[aquic002@gmail.com rtulino@gmail.com]
  end
end
