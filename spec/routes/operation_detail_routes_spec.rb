# frozen_string_literal: true

RSpec.describe 'routes for Operations-details-controller', type: :routing do
  it 'routes /operations-detail to the operations-details controller' do
    expect(get('/operations/new')).to route_to('operations#new')
  end
end
