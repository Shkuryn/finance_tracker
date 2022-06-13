# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'planned_expences/show', type: :view do
  before(:each) do
    @planned_expence = assign(:planned_expence, PlannedExpence.create!(
                                                  expence: nil,
                                                  description: 'Description',
                                                  sent: false,
                                                  user: nil,
                                                  amount: 2
                                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
