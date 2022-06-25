# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operation, type: :model do
  # before do
  #   @user = FactoryBot.create(:user)
  # @operaton = FactoryBot.create(:operation, user_id: @user.id)
  #   @expence = FactoryBot.create(:expence, user_id: @user.id)
  # end
  # describe '#create' do
  #   context 'successfully' do
  #     it 'is valid when all fields is filled' do
  #       expect(@operaton).to be_valid
  #     end
  #   end
  #   context 'unsuccessfully' do
  #     it 'is invalid if date is empty' do
  #       @operaton.date = nil
  #       expect(@operaton).not_to be_valid
  #     end
  #     it 'is invalid when date too old' do
  #       @operaton.date = 100.years.ago
  #       expect(@operaton).not_to be_valid
  #     end
  #     it 'is invalid when date too much ahead' do
  #       @operaton.date = 100.years.from_now
  #       expect(@operaton).not_to be_valid
  #     end
  #   end
  # end
  #
  describe '#with_amount_eq' do
    let(:user) { FactoryBot.create(:user, family_id: 1) }
    let(:operation) { FactoryBot.create(:operation, user_id: user.id) }
    let(:expence) { FactoryBot.create(:expence, user_id: user.id) }
    let!(:operation_detail1) { FactoryBot.create(:operation_detail, id: 12, operation_id: operation.id, amount: 100, expence_id: expence.id) }
    let!(:operation_detail2) { FactoryBot.create(:operation_detail, id: 2, expence_id: expence.id, operation_id: operation.id, amount: 200) }

    it 'has one operation' do
      expect(Operation.with_amount_eq(300).to_a.count).to eq(1)
    end
  end

  describe '#with_amount_gteq' do
    let(:user) { FactoryBot.create(:user) }
    let(:operation) { FactoryBot.create(:operation, user_id: user.id) }
    let(:expence) { FactoryBot.create(:expence, user_id: user.id) }
    let!(:operation_detail1) { FactoryBot.create(:operation_detail, id: 12, operation_id: operation.id, amount: 100, expence_id: expence.id) }
    let!(:operation_detail2) { FactoryBot.create(:operation_detail, id: 2, expence_id: expence.id, operation_id: operation.id, amount: 200) }

    it 'has one operation' do
      expect(Operation.with_amount_eq(300).to_a.count).to eq(1)
    end
  end
  describe '#with_amount_gt' do
    let(:user) { FactoryBot.create(:user) }
    let(:operation) { FactoryBot.create(:operation, user_id: user.id) }
    let(:expence) { FactoryBot.create(:expence, user_id: user.id) }
    let!(:operation_detail1) { FactoryBot.create(:operation_detail, id: 12, operation_id: operation.id, amount: 100, expence_id: expence.id) }
    let!(:operation_detail2) { FactoryBot.create(:operation_detail, id: 2, expence_id: expence.id, operation_id: operation.id, amount: 200) }

    it 'has one operation' do
      expect(Operation.with_amount_gt(50).to_a.count).to eq(1)
    end
  end
  describe '#with_amount_lt' do
    let(:user) { FactoryBot.create(:user) }
    let(:operation) { FactoryBot.create(:operation, user_id: user.id) }
    let(:expence) { FactoryBot.create(:expence, user_id: user.id) }
    let!(:operation_detail1) { FactoryBot.create(:operation_detail, id: 12, operation_id: operation.id, amount: 100, expence_id: expence.id) }
    let!(:operation_detail2) { FactoryBot.create(:operation_detail, id: 2, expence_id: expence.id, operation_id: operation.id, amount: 200) }

    it 'has one operation' do
      expect(Operation.with_amount_lt(50).to_a.count).to eq(0)
    end
  end
  describe '#with_amount_lteq' do
    let(:user) { FactoryBot.create(:user) }
    let(:operation) { FactoryBot.create(:operation, user_id: user.id) }
    let(:expence) { FactoryBot.create(:expence, user_id: user.id) }
    let!(:operation_detail1) { FactoryBot.create(:operation_detail, id: 12, operation_id: operation.id, amount: 100, expence_id: expence.id) }
    let!(:operation_detail2) { FactoryBot.create(:operation_detail, id: 2, expence_id: expence.id, operation_id: operation.id, amount: 200) }

    it 'has one operation' do
      expect(Operation.with_amount_lteq(300).to_a.count).to eq(1)
    end
  end

  describe '#with_family' do
    let(:user) { FactoryBot.create(:user) }
    let(:operation) { FactoryBot.create(:operation, user_id: user.id) }
    it 'should return family operation' do
      expect(Operation.with_family(user.family_id).to_a.count).to eq(0)
    end
  end
  # describe '#purge_attached_image' do
  #   let(:user) { FactoryBot.create(:user) }
  #   subject(:operation) { FactoryBot.create(:operation, user_id: user.id) }
  #   dbl = Double('Operation')
  #   it 'should execute purge' do
  #
  #     allow(dbl).to receive(:purge_attached_image).and_return(true)
  #     expect(subject.purge_attached_image).to eq(true)
  #   end
  #
  # end

  describe '#acceptable_image' do
    let(:user) { FactoryBot.create(:user) }
    subject(:operation) { FactoryBot.create(:operation, user_id: user.id) }
    it 'adds errors if image is too big' do
      subject.image.attach(
        io: File.open("#{Rails.root}/spec/fixtures/too_big.png"),
        filename: 'too_big.png'
      )
      expect(subject.errors.full_messages.to_s).to include('size 12.99 MB exceeds 1 MB limit')
    end
  end

  describe '#purge_attached_image' do
    let(:user) { FactoryBot.create(:user) }
    subject(:operation) { FactoryBot.create(:operation, user_id: user.id) }
    it 'success exec' do

      expect(subject.subject.image.purge_attached_image).to eq(nil)
    end
  end

end
