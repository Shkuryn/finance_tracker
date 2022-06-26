# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IncomesController, type: :controller do
  render_views
  let(:user) { FactoryBot.create :user }
  let(:income) { FactoryBot.create(:income, user_id: user.id) }
  let(:user2) { FactoryBot.create(:user, id: 2, name: 'Petr', surname: 'Petrov', email: 'aaa@aaddd.com') }
  let(:income2) { FactoryBot.create(:income, user_id: user2.id, id: 22) }
  let(:income_predefined) { FactoryBot.create(:income, user_id: user2.id, id: 23, predefined: true) }
  describe '#index' do
    # it 'returns a 200' do
    #   get :index
    #   expect(response).to have_http_status(:ok)
    # end
    # it 'renders the index template' do
    #   get :index
    #   expect(response).to render_template('dashboard/index')
    # end

    describe '#show' do
      # it 'to #show if not login' do
      #   get :show, params: { id: income }
      #   expect(response).to have_http_status(:ok)
      #   expect(response.body).to match(/<h3> please login/im)
      #   assert_template('welcome/index')
      # end
    end
    # it 'has a related heading when not signed in' do
    #   get :index
    #   expect(response.body).to match(/<h3> please login/im)
    #   assert_template('welcome/index')
    # end

    it 'has a related heading when  signed in' do
      login_user user
      visit incomes_path income
      expect(page).to have_content('Incomes')
      expect(page).to have_content('Income name')
    end
  end

  describe '#create' do
    subject { FactoryBot.create(:income, user_id: user.id) }
    it 'should create a new income' do
      login_user user
      visit new_income_path
      expect(page).to have_content('New Income')
    end
    it 'success creation' do
      expect { subject }.to change { Income.count }.by(1)
    end
    it 'success addition' do
      expect { subject }.to change { Income.count }.from(0).to(1)
    end
    it 'registered user can add new income' do
      login_user user
      visit new_income_path
      fill_in 'name', with: 'test name'
      fill_in 'description', with: 'test description'
      click_on 'save'
      expect(response).to have_http_status(:ok)
    end
  end
  describe '#update' do
    it 'there is no edit button for predefined income' do
      income = FactoryBot.create(:income, user_id: user.id, predefined: true, id: 22)
      login_user user
      visit "/incomes/#{income.id}/edit"
      expect(have_no_button('Update'))
    end
    it 'there is edit button for non predefined income' do
      login_user user
      visit "/incomes/#{income.id}/edit"
      expect(have_button('Update'))
    end
  end
  describe '#destroy' do
    before { income }
    it 'deletes a incomes' do
      sign_in user
      expect do
        delete :destroy, params: { id: income.id }
      end.to change { Income.count }.by(-1)
      # expect(response).to have_content('#')
    end
  end
end
