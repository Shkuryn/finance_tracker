# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @user1 = FactoryBot.create(:user, id: 2, email: 'test@example.com', name: 'Michael', surname: 'Scot')
    @invitation = FactoryBot.create(:invitation, user: user, member: user1, confirmed: true)
  end

  describe '#members' do
    it 'returns users with invitations' do
      expect(members(@user).to eq(@user1)
    end
  end
  after do
    @user.destroy
  end
end