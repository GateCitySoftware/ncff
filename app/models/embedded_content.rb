class EmbeddedContent < ApplicationRecord
  belongs_to :embeddable, polymorphic: true
end
