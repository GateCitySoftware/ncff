class StageSchedules
  STAGE_ORDER = [
    'CityStage NC @ The Depot',
    'Summit Stage',
    'LeBauer Park',
    'Elm St. Stage',
    'Center City Jams',
    'Dance at Van Dyke'
  ]

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
    ordered_stages = {}
    STAGE_ORDER.each do |stage_name|
      ordered_stages[stage_name] = stages_hash[stage_name] if stages_hash.key?(stage_name)
    end

    # Add any stages that are in the data but not in STAGE_ORDER at the end
    (stages_hash.keys - STAGE_ORDER).each do |stage_name|
      ordered_stages[stage_name] = stages_hash[stage_name]
    end

    ordered_stages
  end

  def format_performances(performances)
    performances.map { |performance| format_performance(performance) }
                .sort_by { |perf| perf[:start_time] }
  end

  def format_performance(performance)
    {
      start_time: performance.start_time,
      end_time: performance.end_time,
      artist_name: performance.artist.name,
      artist_genres: performance.artist.genres
    }
  end
end
