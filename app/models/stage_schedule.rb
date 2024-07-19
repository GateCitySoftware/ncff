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
class StageSchedule < ApplicationRecord
  belongs_to :stage

  def self.recreate_all!
    stage_date_performances = Performance.all.group_by do |p|
      "#{p.stage.name} - #{p.start_time.to_date.strftime('%A')}"
    end

    stage_date_performances.each do |name, performances|
    end
  end
end
