# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OperationsController, type: :controller do
  render_views
  before do
    @user = FactoryBot.create(:user)
    @operaton = FactoryBot.create(:operation, user_id: @user.id)
    @expence = FactoryBot.create(:expence, user_id: @user.id)
    @operaton_detail = FactoryBot.build(:operation_detail, expence_id: @expence.id, operation_id: @operaton.id)
  end

  describe 'GET index' do
    it 'returns a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'return correct operation count' do
      other_user = FactoryBot.create(:user, id: 2, name: 'Petr', surname: 'Petrov', email: 'aaa@aaddd.com')
      FactoryBot.create(:operation, user_id: other_user.id, id: 22)
      FactoryBot.create(:operation, user_id: other_user.id, id: 23)
      operation_count = Operation.count
      operation_count_user = Operation.with_user(@user.id).count
      operation_count_other_user = Operation.with_user(other_user.id).count
      expect(operation_count).to eq(3)
      expect(operation_count_user).to eq(1)
      expect(operation_count_other_user).to eq(2)
    end
  end
  describe 'GET show' do
    it 'to #show' do
      get :show, params: { id: @operaton }
    end
  end
  describe '#create' do
    it 'get correct heading' do
      sign_in @user
      get :edit, params: { id: @operaton }
      expect(response.body).to match(/<h1>Editing Operation/)
    end
    it 'redirect to welcome page if try edit alien page' do
      user2 = FactoryBot.create(:user, id: 2, name: 'Petr', surname: 'Petrov', email: 'aaa@aaddd.com')
      operation2 = FactoryBot.create(:operation, user_id: user2.id, id: 22)
      sign_in @user
      get :edit, params: { id: operation2 }
      expect(response.body).to match(/<h1>Welcome/)
    end
    it 'redirect to welcome page if try to show alien page' do
      user2 = FactoryBot.create(:user, id: 2, name: 'Petr', surname: 'Petrov', email: 'aaa@aaddd.com')
      operation2 = FactoryBot.create(:operation, user_id: user2.id, id: 22)
      sign_in @user
      get :show, params: { id: operation2 }
      expect(response.body).to match(/<h1>Welcome/)
    end

    it 'stay the same page' do
      login_user
      visit "/operations/#{@operaton.id}/edit"
      click_on 'save'
      expect(page).to have_content('Editing Operation')
    end
    it 'stay the same page after adding row with amount' do
      login_user
      visit "/operations/#{@operaton.id}/edit"
      click_on 'save'
      fill_in 'amount', with: 5.0
      click_on 'commit'
      expect(page).to have_content('Editing Operation')
      expect(page).to have_content('Operation was successfully updated')
    end
    it 'stay the same page after adding row without amount' do
      login_user
      visit "/operations/#{@operaton.id}/edit"
      click_on 'save'
      click_on 'commit'
      expect(page).to have_content('Editing Operation')
      expect(page).to have_content('Amount must be filled!')
    end
  end
  after do
    @user.destroy
    @operaton.destroy
  end
end
