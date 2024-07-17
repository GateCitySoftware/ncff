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
