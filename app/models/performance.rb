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
end
