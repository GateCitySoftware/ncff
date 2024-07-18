require 'rails_helper'

RSpec.describe "stage_schedules/edit", type: :view do
  let(:stage_schedule) {
    StageSchedule.create!(
      id: "",
      name: "MyString",
      stage: nil
    )
  }

  before(:each) do
    assign(:stage_schedule, stage_schedule)
  end

  it "renders the edit stage_schedule form" do
    render

    assert_select "form[action=?][method=?]", stage_schedule_path(stage_schedule), "post" do

      assert_select "input[name=?]", "stage_schedule[id]"

      assert_select "input[name=?]", "stage_schedule[name]"

      assert_select "input[name=?]", "stage_schedule[stage_id]"
    end
  end
end
