class StageSchedules
  def self.generate
    new.generate
  end

  def generate
    {
      stages: Stage.pluck(:name),
      schedule_days: group_performances_by_date.map do |date, performances|
        {
          name: date_to_day_name(date),
          events: format_performances(performances)
        }
      end
    }
  end

  private

  def group_performances_by_date
    Performance.all.includes(:stage, :artist).group_by { |performance| performance.start_time.to_date }
  end

  def date_to_day_name(date)
    date.strftime('%A')
  end

  def format_performances(performances)
    performances.map { |performance| format_performance(performance) }
                .sort_by { |perf| perf[:time_range] }
  end

  def format_performance(performance)
    {
      time_range: display_time(performance),
      title: performance.artist.name,
      description: "Performance at #{performance.stage.name}",
      stage: performance.stage.name,
      artists: [format_artist(performance.artist)]
    }
  end

  def format_artist(artist)
    {
      name: artist.name,
      avatar: artist.primary_image
    }
  end

  def display_time(performance)
    if performance.end_time
      "#{performance.start_time.strftime('%-l:%M %p')} - #{performance.end_time.strftime('%-l:%M %p')}"
    else
      performance.start_time.strftime('%-l:%M %p')
    end
  end
end
