require 'rails_helper'

RSpec.describe "stage_schedules/new", type: :view do
  before(:each) do
    assign(:stage_schedule, StageSchedule.new(
      id: "",
      name: "MyString",
      stage: nil
    ))
  end

  it "renders new stage_schedule form" do
    render

    assert_select "form[action=?][method=?]", stage_schedules_path, "post" do

      assert_select "input[name=?]", "stage_schedule[id]"

      assert_select "input[name=?]", "stage_schedule[name]"

      assert_select "input[name=?]", "stage_schedule[stage_id]"
    end
  end
end
