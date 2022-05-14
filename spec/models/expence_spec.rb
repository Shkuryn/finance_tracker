require 'rails_helper'

RSpec.describe Expence, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @expence = FactoryBot.build(:expence, user_id:  @user.id)
  end

  describe '#create' do
    context 'successfully' do
      it 'is valid with name, description' do
        expect(@expence).to be_valid
      end
    end

    context 'unsuccessfully' do
      it 'is invalid without title' do
      end

      it 'is invalid without content' do
      end
    end
  end
  after do
    @user.destroy
  end
end
