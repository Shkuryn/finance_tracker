# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlannedExpenceMailer, type: :mailer do
  describe '#notification_about_expence' do
    let(:user) { FactoryBot.create :user }
    let(:mail) { PlannedExpenceMailer.notification_about_expence(user) }

    # it "renders the headers" do
    #   expect(mail.subject).to eq('Notification about planned expence | FinanceTracker')
    #   expect(mail.to).to eq([user.email])
    #   expect(mail.from).to eq(['dreamteamc2022@gmail.com'])
    # end

    # it "renders the body" do
    #     expect(mail.body.encoded).to match("Notification about your planned expence! Plese visit this URL for show more details")
    # end
  end
end
