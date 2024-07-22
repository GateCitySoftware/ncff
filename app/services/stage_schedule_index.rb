class StageScheduleIndex
  DATES = %w[2024-09-06 2024-09-07 2024-09-08]
  DATA = Struct.new(:page_name, :stage_schedules, :active_date, :date, :stage, :dates)
  PAGE_NAME = 'NC Folk Festival Stage Schedules'

  def self.all(date, stage)
    new(date, stage).call
  end

  def initialize(date, stage)
    @date_param = date
    @date = select_date(date)
    @stage = stage
  end

  def call
    DATA.new(PAGE_NAME, stage_schedules, active_date, @date, @stage, Performance::DATES_2024)
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

  def active_date
    @date_param || default_date(@date_param)
  end
end
