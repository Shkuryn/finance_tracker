# frozen_string_literal: true

require 'rails_helper'
require 'requests_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) {FactoryBot.create :user}
  describe 'GET #show' do
    context 'when a user is logged in' do
      before do
        sign_in user
      end
      it 'loads correct user details' do
        get :show, params: { id: user.id }
        expect(assigns(:user)).to eq user
      end
    end
  end 
end