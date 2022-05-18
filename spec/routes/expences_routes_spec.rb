# frozen_string_literal: true

RSpec.describe 'routes for Expences-controller', type: :routing do
  it 'routes /expenses to the expences controller' do
    expect(get('/expences')).to route_to('expences#index')
  end

  it 'routes /expences-new to the expences controller' do
    expect(get('/expences/new')).to route_to('expences#new')
  end
end
