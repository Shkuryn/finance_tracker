# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'planned_expences/new', type: :view do
  before(:each) do
    assign(:planned_expence, PlannedExpence.new(
                               expence: nil,
                               description: 'MyString',
                               sent: false,
                               user: nil,
                               amount: 1
                             ))
  end

  it 'renders new planned_expence form' do
    render

    assert_select 'form[action=?][method=?]', planned_expences_path, 'post' do
      assert_select 'input[name=?]', 'planned_expence[expence_id]'

      assert_select 'input[name=?]', 'planned_expence[description]'

      assert_select 'input[name=?]', 'planned_expence[sent]'

      assert_select 'input[name=?]', 'planned_expence[user_id]'

      assert_select 'input[name=?]', 'planned_expence[amount]'
    end
  end
end
