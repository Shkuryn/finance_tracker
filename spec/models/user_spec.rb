# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user_parent = FactoryBot.create(:user, family_id: 1)
    @user_member = FactoryBot.create(:user, id: 2, email: 'test@example.com', name: 'Michael', surname: 'Scot', family_id: 1)
    # @invitation = FactoryBot.create(:invitation, user: user, member: user1, confirmed: true)
    @family = FactoryBot.create(:family, id: 1, parent_id: @user_parent.id)
  end

  describe '#family_member?' do
    let(:id) { 2 }
    it 'check if member' do
      expect(@user_member.family_id).present?
      expect(@user_member.id).not_to eq(@family.parent_id)
      expect(id).not_to eq(Family.find(@family.id).parent_id)
      expect(@user_member.family_member?).to eq(true)
    end
    it 'check if parent' do
      expect(@user_parent.family_id).present?
      expect(@user_parent.id).to eq(@family.parent_id)
      expect(@user_parent.family_member?).to eq(false)
    end
  end

  describe '#family_parent?' do
    let(:id) { 1 }
    it 'check if member' do
      expect(@user_member.family_id).present?
      expect(@user_member.family_parent?).to eq(false)
    end
    it 'check if parent' do
      expect(@user_parent.family_id).present?
      expect(@user_parent.id).to eq(@family.parent_id)
      expect(@user_parent.family_parent?).to eq(true)
    end
  end
end
