# == Schema Information
#
# Table name: stage_schedules
#
#  id         :uuid             not null, primary key
#  name       :string
#  date       :date
#  stage_id   :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe StageSchedule, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
