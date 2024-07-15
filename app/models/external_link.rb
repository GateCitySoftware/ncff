class ExternalLink < ApplicationRecord
  belongs_to :linkable, polymorphic: true
end
