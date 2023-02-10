# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlannedExpencesController, type: :controller do
  render_views
  let(:expence) { FactoryBot.create(:expence, user_id: user.id) }
  let(:user) { FactoryBot.create :user }
  let(:planned_expence) { FactoryBot.create(:planned_expence, expence_id: expence.id, user_id: user.id) }
  let(:user2) { FactoryBot.create(:user, id: 2, name: 'Petr', surname: 'Petrov', email: 'aaa@aaddd.com') }
  let(:planned_expence2) { FactoryBot.create(:planned_expence, expence_id: expence.id, user_id: user2.id, id: 22) }
  describe '#index' do
    it 'returns a 200' do
      pending 'Not yet implemented ...'
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'renders the index template' do
      pending 'Not yet implemented ...'
      get :index
      expect(response).to render_template('welcome/index')
    end
    # it 'return correct planned expences count' do
    #   expences_count = PlannedExpence.count
    #   expences_count_user1 = PlannedExpence.with_user(user.id).count
    #   expences_count_user2 = PlannedExpence.with_user(user2.id).count
    #   expect(expences_count).to eq(2)
    #   expect(expences_count_user1).to eq(1)
    #   expect(expences_count_user2).to eq(1)
    # end
  end
  describe '#new' do
    it 'can open' do
      pending 'add some examples'
      login_user user
      visit new_planned_expence_path
      expect(page).to have_content('New Planned Expence')
    end
  end

  describe '#show' do
    # it 'to #show if not login' do
    #   get :show, params: { expence: expence }
    #   expect(response).to have_http_status(:ok)
    #   expect(response.body).to match(/<h3> please login/im)
    #   assert_template('welcome/index')
    # end

    # it 'has a related heading when not signed in' do
    #   get :index
    #   expect(response.body).to match(/<h3> please login/im)
    #   assert_template('welcome/index')
    # end

    # it 'has a related heading when  signed in' do
    #   login_user user
    #   visit planned_expence_path planned_expence
    #   expect(page).to have_content('Editing Planned Expence')
    # end
  end
end
