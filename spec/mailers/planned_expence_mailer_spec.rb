# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlannedExpenceMailer, type: :mailer do
  describe '#notification_about_expence' do
    let(:user) { FactoryBot.create :user }
    let(:expence) { FactoryBot.create(:expence, user_id: user.id) }
    let(:planned_expence) { FactoryBot.create(:planned_expence, user_id: user.id, expence_id: expence.id, date: Time.now) }
    let(:mail) { PlannedExpenceMailer.notification_about_expence(user, planned_expence) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Notification about planned expence | FinanceTracker')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['dreamteamc2022@gmail.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('It is notification about your planned expence!'.to_s)
      expect(mail.body.encoded).to include('Please, visit this URL for show more details:'.to_s)
    end
  end
end
