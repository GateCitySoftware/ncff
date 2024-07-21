
class StageScheduleIndex 
  DATES = ['2024-09-06', '2024-09-07', '2024-09-08']
  DATA = Struct.new(:stage_schedules, :date, :stage, :dates)

  def self.all(date, stage)
    new(date, stage).call
  end

  def initialize(date, stage)
    @date = select_date(date)
    @stage = stage
  end

  def call
    DATA.new(stage_schedules, @date, @stage, Performance::DATES_2024)
  end

  private

  def stage_schedules 
    @stage.nil? ? data : data[@stage]
  end

  def data
    @data ||= StageSchedules.generate[@date]
  end

  def select_date(date)
    DATES.include?(date) ? date : default_date(date)
  end

  def default_date(date)
    if DATES.include?(Date.today.to_s)
      Date.today.to_s
    else
      DATES.first
    end
  end
end
