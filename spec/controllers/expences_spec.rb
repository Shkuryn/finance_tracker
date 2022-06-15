# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExpencesController, type: :controller do
  render_views
  let(:user) { FactoryBot.create :user }
  let(:expence) { FactoryBot.create(:expence, user_id: user.id) }
  let(:user2) { FactoryBot.create(:user, id: 2, name: 'Petr', surname: 'Petrov', email: 'aaa@aaddd.com') }
  let(:expence2) { FactoryBot.create(:expence, user_id: user2.id, id: 22) }
  let(:expence_predefined) { FactoryBot.create(:expence, user_id: user2.id, id: 23, predefined: true) }
  describe '#index' do
    it 'returns a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('welcome/index')
    end
    it 'return correct expences count' do
      # TODO: rid it off
      user2 = FactoryBot.create(:user, id: 2, name: 'Petr', surname: 'Petrov', email: 'aaa@aaddd.com')
      expence = FactoryBot.create(:expence, user_id: user.id)
      expence2 = FactoryBot.create(:expence, user_id: user2.id, id: 22)
      expence_predefined = FactoryBot.create(:expence, user_id: user2.id, id: 23, predefined: true)
      expences_count = Expence.count
      expences_count_user1 = Expence.where(predefined: true).or(Expence.with_user(user.id)).count
      expences_count_user2 = Expence.where(predefined: true).or(Expence.with_user(user2.id)).count
      expect(expences_count).to eq(3)
      expect(expences_count_user1).to eq(2)
      expect(expences_count_user2).to eq(2)
    end
    describe '#show' do
      it 'to #show if not login' do
        get :show, params: { id: expence }
        expect(response).to have_http_status(:ok)
        expect(response.body).to match(/<h3> please login/im)
        assert_template('welcome/index')
      end
    end
    it 'has a related heading when not signed in' do
      get :index
      expect(response.body).to match(/<h3> please login/im)
      assert_template('welcome/index')
    end

    it 'has a related heading when  signed in' do
      login_user user
      visit expences_path expence
      expect(page).to have_content('Expences')
      expect(page).to have_content('Great name')
    end
  end
  describe '#create' do
    it 'should create a new expence' do
      login_user user
      visit new_expence_path
      expect(page).to have_content('New Expence')
    end
  end
  describe '#update' do
    it 'there is no edit button for predefined expence' do
      expence = FactoryBot.create(:expence, user_id: user.id, predefined: true, id: 22)
      login_user user
      visit "/expences/#{expence.id}/edit"
      expect(have_no_button('Update'))
    end
    it 'there is edit button for non predefined expence' do
      login_user user
      visit "/expences/#{expence.id}/edit"
      expect(have_button('Update'))
    end
  end
end
