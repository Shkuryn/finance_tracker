# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'admin@finance_tracker.com'
  layout 'mailer'
end
