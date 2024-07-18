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
