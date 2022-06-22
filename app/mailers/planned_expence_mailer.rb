# frozen_string_literal: true

class PlannedExpenceMailer < ApplicationMailer
  def notification_about_expence(user, planned_expence)
    @user = user
    @planned_expence = planned_expence
    mail to: @user.email, subject: 'Notification about planned expence | FinanceTracker'
  end
end
