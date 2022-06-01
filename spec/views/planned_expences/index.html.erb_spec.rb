# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'planned_expences/index', type: :view do
  before(:each) do
    assign(:planned_expences, [
             PlannedExpence.create!(
               expence: nil,
               description: 'Description',
               sent: false,
               user: nil,
               amount: 2
             ),
             PlannedExpence.create!(
               expence: nil,
               description: 'Description',
               sent: false,
               user: nil,
               amount: 2
             )
           ])
  end

  it 'renders a list of planned_expences' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Description'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end

end
