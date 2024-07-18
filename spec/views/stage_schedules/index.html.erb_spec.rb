require 'rails_helper'

RSpec.describe "stage_schedules/index", type: :view do
  before(:each) do
    assign(:stage_schedules, [
      StageSchedule.create!(
        id: "",
        name: "Name",
        stage: nil
      ),
      StageSchedule.create!(
        id: "",
        name: "Name",
        stage: nil
      )
    ])
  end

  it "renders a list of stage_schedules" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
