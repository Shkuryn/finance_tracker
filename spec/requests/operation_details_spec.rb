# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OperationDetailsController, type: :controller do
  render_views
  let(:user) { FactoryBot.create :user }
  let(:other_user) { FactoryBot.create(:user, id: 2, name: 'Petr', surname: 'Petrov', email: 'aaa@aaddd.com') }
  let(:expence) { FactoryBot.create(:expence, user_id: user.id) }
  let(:operation) { FactoryBot.create(:operation, user_id: user.id) }
  let(:operation_detail) {
    FactoryBot.create(:operation_detail, expence_id: expence.id,
                      operation_id: operation.id, amount: 100) }

  describe '#show' do
    subject(:user2) { FactoryBot.create(:user, id: 2, name: 'Petr', surname: 'Petrov', email: 'aaa@aaddd.com') }
    # it 'to #show' do
    #   get :show, params: { operation_detail_id: operation_detail }
    # end
    # it 'redirect to welcome page if try to show alien page' do
    #   sign_in user2
    #   get :show, params: { id: operation_detail }
    #   expect(response.body).to match(/<h1>Welcome/)
    #   expect(response).to render_template('welcome/index')
    # end
    it 'status ok for own page' do
      pending 'Not yet implemented ...'
      sign_in user
      get :show, params: { id: operation_detail }
      redirect_to("/operation_details/#{assigns(:operation_detail).id}")
    end
    describe '#edit' do
      it 'status ok for own page' do
        pending 'Not yet implemented ...'
        sign_in user
        get :edit, params: { id: operation_detail }
        expect(response).to have_http_status(:ok)
      end
    end
    describe '#create' do
      subject { FactoryBot.create(:operation_detail, expence_id: expence.id, operation_id: operation.id) }
      it 'success creation' do
        pending 'Not yet implemented ...'
        expect { subject }.to change { OperationDetail.count }.by(1)
      end
      it 'success addition' do
        pending 'Not yet implemented ...'
        expect { subject }.to change { OperationDetail.count }.from(0).to(1)
      end
      it 'registered user can add operation details' do
        pending 'Not yet implemented ...'
        login_user user
        visit "/operations/#{operation.id}/edit"
        fill_in 'comment', with: 'test comment'
        fill_in 'amount', with: 5.5
        click_on 'Add'
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#destroy' do
    before { operation_detail }
    it 'deletes a operation' do
      sign_in user
      expect do
        delete :destroy, params: { id: operation_detail.id }
      end.to change { OperationDetail.count }.by(-1)
      # expect(response).to have_content('#')
    end
  end
  describe '#update' do
    before do
      operation_detail
    end

    it 'update a OperationDetail' do
      sign_in user
      expect do
        expect { patch :update, operation_detail: operation_detail, id: id }
      end.to change { OperationDetail.count }.by(0)
      expect(response.status).to eq 200
    end
  end
end
