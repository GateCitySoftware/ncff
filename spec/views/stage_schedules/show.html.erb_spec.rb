require 'rails_helper'

RSpec.describe "stage_schedules/show", type: :view do
  before(:each) do
    assign(:stage_schedule, StageSchedule.create!(
      id: "",
      name: "Name",
      stage: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
