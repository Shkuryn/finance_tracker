# frozen_string_literal: true

RSpec.describe 'routes for Operations-controller', type: :routing do
  it 'routes /operations to the operations controller' do
    expect(get('/operations')).to route_to('operations#index')
  end
end
