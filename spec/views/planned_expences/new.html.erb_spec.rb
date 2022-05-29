require 'rails_helper'

RSpec.describe "planned_expences/new", type: :view do
  before(:each) do
    assign(:planned_expence, PlannedExpence.new())
  end

  it "renders new planned_expence form" do
    render

    assert_select "form[action=?][method=?]", planned_expences_path, "post" do
    end
  end
end
