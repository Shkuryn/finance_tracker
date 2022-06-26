# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OperationsHelper, type: :helper do
  let!(:user) { FactoryBot.create :user }
  let!(:income) { FactoryBot.create(:income, user_id: user.id) }
  let!(:operation) { FactoryBot.create(:operation, user_id: user.id) }
  let!(:operation_detail) { FactoryBot.create(:operation_detail, operation_id: operation.id, amount: 100, income_id: income.id) }
  let!(:operation_detail1) { FactoryBot.create(:operation_detail, id: 2, operation_id: operation.id, amount: 100, income_id: income.id) }
  describe '#operation_sum' do
    it 'sums all operation_details for operation' do
      expect(helper.operation_sum(operation.id)).to eq(200)
    end
  end

  describe '#author' do
    it 'returns name and surname of user by id' do
      expect(helper.author(operation.user_id)).to eq('John Doe')
    end
  end
end
