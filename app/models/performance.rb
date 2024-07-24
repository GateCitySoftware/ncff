# frozen_string_literal: true

# == Schema Information
#
# Table name: performances
#
#  id          :uuid             not null, primary key
#  stage_id    :uuid             not null
#  artist_id   :uuid             not null
#  start_time  :datetime
#  end_time    :datetime
#  description :text
#  is_headline :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Performance < ApplicationRecord
  belongs_to :stage
  belongs_to :artist

  DATES_2024 = %w[2024-09-06 2024-09-07 2024-09-08]

  def self.stage_map
    Rails.cache.fetch('stage_map', expires_in: 1.hour) do
      Performance.includes(:stage).all.group_by { |p| p.stage.name }.transform_values(&:count)
    end
  end

  def self.date_map
    Rails.cache.fetch('date_map', expires_in: 1.hour) do
      Performance.all.group_by { |p| p.start_time.to_date }.transform_values(&:count)
    end
  end

  def self.create_summary_json_file
    File.open('tmp/performances.json', 'w') do |f|
      f.write(JSON.pretty_generate(all.map(&:summary)))
    end
  end

  def summary
    {
      date: start_time.to_date,
      time: start_time,
      stage: stage.name,
      genres: artist.genres
    }
  end
end
