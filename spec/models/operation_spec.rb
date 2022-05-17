# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operation, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @operaton = FactoryBot.build(:operation, user_id: @user.id)
  end
  describe '#create' do
    context 'successfully' do
      it 'is valid when all fields is filled' do
        expect(@operaton).to be_valid
      end
    end
    context 'unsuccessfully' do
      it 'is invalid if date is empty' do
        @operaton.date = nil
        expect(@operaton).not_to be_valid
      end
      it 'is invalid when date too old' do
        @operaton.date = 100.years.ago
        expect(@operaton).not_to be_valid
      end
      it 'is invalid when date too much ahead' do
        @operaton.date = 100.years.from_now
        expect(@operaton).not_to be_valid
      end
    end
  end
  after do
    @user.destroy
  end
end
