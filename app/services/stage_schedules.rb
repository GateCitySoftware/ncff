class StageSchedules
  def self.generate
    new.generate
  end

  def generate
    group_performances_by_date.transform_values do |performances_by_date|
      order_stages(group_performances_by_stage(performances_by_date))
    end
  end

  private

  def group_performances_by_date
    Performance.all.group_by { |performance| performance.start_time.to_date.to_s }
  end

  def group_performances_by_stage(performances)
    performances.group_by { |performance| performance.stage.name }
                .transform_values { |stage_performances| format_performances(stage_performances) }
  end

  def order_stages(stages_hash)
    stages_hash.sort_by { |stage, data| Stage::STAGE_ORDER.index(stage) }
  end

  def format_performances(performances)
    performances.map { |performance| format_performance(performance) }
                .sort_by { |perf| perf[:start_time] }
  end

  def format_performance(performance)
    {
      start_time: performance.start_time,
      display_time: display_time(performance),
      artist_name: performance.artist.name,
      artist_genres: performance.artist.genres,
      artist_image: performance.artist.card_image
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
