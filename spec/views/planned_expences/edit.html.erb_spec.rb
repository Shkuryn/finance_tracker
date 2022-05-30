# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'planned_expences/edit', type: :view do
  before(:each) do
    @planned_expence = assign(:planned_expence, PlannedExpence.create!)
  end

  it 'renders the edit planned_expence form' do
    render

    assert_select 'form[action=?][method=?]', planned_expence_path(@planned_expence), 'post' do
    end
  end
end
