require 'rails_helper'

RSpec.describe Expence, type: :model do
  describe 'validation' do
    subject(:exp) do
      FactoryBot.create(:user)
      FactoryBot.create(:expence, user_id: 1)
    end
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  end
end
