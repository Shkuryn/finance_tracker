# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlannedExpencesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/planned_expences').to route_to('planned_expences#index')
    end

    it 'routes to #new' do
      expect(get: '/planned_expences/new').to route_to('planned_expences#new')
    end

    it 'routes to #show' do
      expect(get: '/planned_expences/1').to route_to('planned_expences#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/planned_expences/1/edit').to route_to('planned_expences#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/planned_expences').to route_to('planned_expences#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/planned_expences/1').to route_to('planned_expences#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/planned_expences/1').to route_to('planned_expences#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/planned_expences/1').to route_to('planned_expences#destroy', id: '1')
    end
  end
end
