# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlannedExpencesHelper, type: :helper do
  let(:user) { FactoryBot.create :user }
  let(:expence) { FactoryBot.create(:expence, user_id: user.id) }
  describe '#planned_expence_name' do
    it 'returns expence_name' do
      expect(helper.planned_expence_name(expence.id)).to eq(expence.name)
    end
  end

  describe '#send_email' do
    it 'returns user' do
      expect(helper.send_email(user.id)).to eq(user)
    end
  end
end
