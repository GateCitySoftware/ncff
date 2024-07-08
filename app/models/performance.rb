# frozen_string_literal: true

class Performance < ApplicationRecord
  belongs_to :stage
  belongs_to :artist
end
