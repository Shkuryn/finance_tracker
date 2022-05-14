# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expence, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @expence = FactoryBot.build(:expence, user_id:  @user.id)
  end

  describe '#create' do
    context 'successfully' do
      it 'is valid when all fields is filled' do
        expect(@expence).to be_valid
      end
    end

    context 'unsuccessfully' do
      it 'is invalid without name' do
        @expence.name = nil
        expect(@expence).not_to be_valid
      end
      it 'is invalid when name is too short' do
        @expence.name = 'IS'
        expect(@expence).not_to be_valid
      end
      it 'is invalid when name is too long' do
        name = ''
        51.times do
          name += 'a'
        end
        @expence.name = name
        expect(@expence).not_to be_valid
      end

      it 'is invalid without user_id' do
        @expence.user_id = nil
        expect(@expence).not_to be_valid
      end
      it 'is invalid without correct user_id' do
        @expence.user_id = '999'
        expect(@expence).not_to be_valid
      end
    end
  end
  after do
    @user.destroy
  end
end
