# frozen_string_literal: true

class PlannedExpenceMailer < ApplicationMailer
  def notification_about_expence
    @user = params[:user]
    mail to: @user.email, subject: 'Notification about planned expence | FinanceTracker'
  end
end
