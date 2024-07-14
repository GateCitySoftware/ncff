module Uploadable
  extend ActiveSupport::Concern

  included do
    has_many :uploads, as: :uploadable
  end
end
