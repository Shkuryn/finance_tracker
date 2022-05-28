require 'rails_helper'

RSpec.describe "planned_expences/show", type: :view do
  before(:each) do
    @planned_expence = assign(:planned_expence, PlannedExpence.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
