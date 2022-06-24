# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  render_views
  let(:user) { FactoryBot.create :user }
  let(:user2) { FactoryBot.create(:user, id: 2, name: 'Petr', surname: 'Petrov', email: 'aaa@aaddd.com') }
  let(:email) { 'aaa@aaddd.com' }

  describe '#create' do
    subject { FactoryBot.create(:invitation, user_id: user.id, member_id: user2.id) }
    it 'should create a new expence' do
      # login_user user2
      # visit user_path
      # expect(page).to have_content('New Expence')
    end
    it 'success creation' do
      expect { subject }.to change { Invitation.count }.by(1)
    end
    it 'success addition' do
      expect { subject }.to change { Invitation.count }.from(0).to(1)
    end

    it 'not confirmed' do
      expect(subject.confirmed).to be_falsey
    end

    it 'success fins user' do
      member = User.with_email(email)
      expect(member).present?
    end
    it 'registered user can create invitation' do
      login_user user
      visit user_path(user)
      fill_in 'invitation[email]', with: user2.email
      click_on 'commit'
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#set_invitation' do
    let!(:invitation) { FactoryBot.create :invitation, user_id: user.id, member_id: user2.id }
    params = { :id => 1 }

    it 'success set' do
      # get invitation_path(invitation)
      @invitation = Invitation.find(params[:id])
      expect(@invitation).present?
    end
  end

  describe '#destroy' do
    let!(:invitation) { FactoryBot.create :invitation, user_id: user.id, member_id: user2.id }
    params = { :id => 1 }

    it 'success destroy' do
      @invitation = Invitation.find(params[:id])
      expect do
        @invitation.destroy
      end.to change(Invitation, :count).by(-1)
    end
    it 'destroy by decline click' do
      # login_user user
      # visit user_path(user)
      # fill_in 'invitation[email]', with: user2.email
      # click_on 'commit'
      # login_user user2
      # visit user_path(user2)
      #
      # click_link(href: 'http://localhost:3000/invitations/1')
      # expect(response).to have_http_status(:ok)
    end

  end
end

