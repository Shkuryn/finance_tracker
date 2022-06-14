# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OperationDetailsController, type: :controller do
  render_views
  let(:user) { FactoryBot.create :user }
  let(:other_user) { FactoryBot.create(:user, id: 2, name: 'Petr', surname: 'Petrov', email: 'aaa@aaddd.com') }
  let(:expence) { FactoryBot.create(:expence, user_id: user.id) }
  let(:operation) { FactoryBot.create(:operation, user_id: user.id) }
  let(:operation_detail) { FactoryBot.create(:operation_detail, expence_id: expence.id, operation_id: operation.id) }

  describe '#how' do
    subject(:user2) { FactoryBot.create(:user, id: 2, name: 'Petr', surname: 'Petrov', email: 'aaa@aaddd.com') }
    # let(:operation2) { FactoryBot.create(:operation, user_id: user2.id) }
    # let(:operation_detail2) { FactoryBot.create(:operation_detail, expence_id: expence.id, operation_id: operation.id) }
    it 'to #show' do
      get :show, params: { id: operation_detail }
    end
    it 'redirect to welcome page if try to show alien page' do
      sign_in user2
      get :show, params: { id: operation_detail }
      expect(response.body).to match(/<h1>Welcome/)
      expect(response).to render_template('welcome/index')
    end
    it 'status ok for own page' do
      sign_in user
      get :show, params: { id: operation_detail }
      redirect_to("/operation_details/#{assigns(:operation_detail).id}")
    end
    describe '#edit' do
      it 'status ok for own page' do
        sign_in user
        get :edit, params: { id: operation_detail }
        expect(response).to have_http_status(:ok)
      end
    end
    describe '#create' do
      subject { FactoryBot.create(:operation_detail, expence_id: expence.id, operation_id: operation.id) }
      it 'success creation' do
        expect { subject }.to change { OperationDetail.count }.by(1)
      end
      it 'success addition' do
        expect { subject }.to change { OperationDetail.count }.from(0).to(1)
      end
      it 'registered user can add operation details' do
        login_user user
        visit "/operations/#{operation.id}/edit"
        fill_in 'comment', with: 'test comment'
        fill_in 'amount', with: 5.5
        click_on 'Add'
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
