# frozen_string_literal: true

class PlannedExpenceMailer < ApplicationMailer
  after_action :change_planned_expence_status

  def notification_about_expence(user, planned_expence)
    @user = user
    @planned_expence = planned_expence
    mail to: @user.email, subject: 'Notification about planned expence | FinanceTracker'
  end

  private

  def change_planned_expence_status
    @planned_expence.update_attribute(:sent, true)
  end
end
