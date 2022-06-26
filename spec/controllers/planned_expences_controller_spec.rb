# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlannedExpencesController, type: :controller do
  render_views
  let(:user) { FactoryBot.create :user }
  let(:expence) { FactoryBot.create(:expence, user_id: user.id) }
  let(:planned_expence) { FactoryBot.create(:planned_expence, user_id: user.id, amount: 10, expence_id: expence.id) }
  let(:user2) { FactoryBot.create(:user, id: 2, name: 'Dmitry', surname: 'Usik', email: 'test@example.com') }
  let(:planned_expence2) { FactoryBot.create(:planned_expence, user_id: user2.id, id: 2, amount: 10, expence_id: expence.id) }

  describe '#index' do
    it 'returns status 200 OK' do
      allow(controller).to receive(:check_user_signed).and_return(true)
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'renders the index template' do
      allow(controller).to receive(:check_user_signed).and_return(true)
      allow(controller).to receive(:check_user_owner).and_return(false)
      get :index
      expect(response).to render_template("planned_expences/index", "layouts/application")
    end
    it 'returns only current user planned expences' do
      login_user user
      expect(planned_expence.amount).to eq(10)
    end
    it 'returns only current user planned expences' do
      login_user user
      expect(planned_expence.user_id).to eq(user.id)
    end
  end

  describe '#show' do
    it 'has a related heading when not signed in' do
      allow(controller).to receive(:signed_in?).and_return(false)
      get :index
      expect(response).to be_redirect
    end
  end

  describe '#create' do
    it 'shoud creates a new planned expence' do
      login_user user
      visit new_planned_expence_path
      expect(page).to have_content('New Planned Expence')
    end
    it 'creates an class instance' do
      expect { planned_expence }.to change { PlannedExpence.count }.by(1)
    end
    it 'registered user can add new planned expence' do
      expence3 = FactoryBot.create(:expence, user_id: user.id, predefined: true, name: 'test', id: 30)
      login_user user
      visit new_planned_expence_path
      select expence3.name, from: 'planned_expence[expence_id]'
      fill_in 'planned_expence[description]', with: 'test description'
      fill_in 'planned_expence[amount]', with: 20
      click_on 'commit'
      expect(response).to have_http_status(:ok)
      expect(planned_expence.user_id).to eq(user.id)
      expect(planned_expence.sent).to eq(false)
    end
  end

  describe '#destroy' do
    before {planned_expence}

    it 'deletes a planned_expence' do
      sign_in user
      expect do
        delete :destroy, params: { id: planned_expence.id }
      end.to change { PlannedExpence.count }.by(-1)
      expect(response).to have_content('#')
    end
  end

  describe '#update' do
    before {planned_expence}

    it 'updates a planned expence' do
      sign_in user
      expect do
        expect { patch :update, planned_expence: planned_expence, id: id }
      end.to change { PlannedExpence.count }.by(0)
      expect(response.status).to eq 200
    end
  end  
end
