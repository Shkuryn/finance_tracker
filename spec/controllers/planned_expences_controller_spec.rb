# frozen_string_literal: true
require 'rails_helper'
RSpec.describe PlannedExpencesController, type: :controller do
  render_views
  let(:user) { FactoryBot.create :user }
  let(:expence) {FactoryBot.create :expence, user_id: user.id}
  let(:planned_expence) { FactoryBot.create(:planned_expence, user_id: user.id, amount: 10, expence_id: expence.id) }
  let(:user2) { FactoryBot.create(:user, id: 2, name: 'Dmitry', surname: 'Usik', email: 'test@example.com') }
  let(:planned_expence2) { FactoryBot.create(:planned_expence2, user_id: user2.id, id: 2, amount: 20, expence_id: expence.id) }
  describe '#index' do
    it 'returns status 200 OK' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('welcome/index')
    end
    it 'returns only current user planned expences' do
      login_user user
      expect(planned_expence.amount).to eq(10)
    end
  end
end