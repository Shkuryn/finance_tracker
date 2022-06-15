# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expence, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @income = FactoryBot.build(:income, user_id: @user.id)
  end

  describe '#create' do
    context 'successfully' do
      it 'is valid when all fields is filled' do
        expect(@income).to be_valid
      end
    end

    context 'unsuccessfully' do
      it 'is invalid without name' do
        @income.name = nil
        expect(@income).not_to be_valid
      end
      it 'is invalid when name is too short' do
        @income.name = 'IS'
        expect(@income).not_to be_valid
      end
      it 'is invalid when name is too long' do
        name = ''
        51.times do
          name += 'a'
        end
        @income.name = name
        expect(@income).not_to be_valid
      end

      it 'is invalid without user_id' do
        @income.user_id = nil
        expect(@income).not_to be_valid
      end
      it 'is invalid without correct user_id' do
        @income.user_id = '999'
        expect(@income).not_to be_valid
      end
    end
  end
  after do
    @user.destroy
  end
end
