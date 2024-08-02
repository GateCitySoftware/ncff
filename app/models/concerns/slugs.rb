module Slugs
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug
    validates :slug, uniqueness: true
  end

  class_methods do
    def sluggable_attributes(*attrs)
      class_variable_set(:@@slug_attrs, attrs)
    end
  end

  private

  def generate_slug
    slug_attrs = self.class.class_variable_get(:@@slug_attrs)
    slug_base = slug_attrs.map { |attr| send(attr).to_s }.join(' ')
    self.slug = unique_slug(slug_base)
  end

  def unique_slug(base)
    slug = base.parameterize
    counter = 1

    while self.class.exists?(slug:)
      slug = "#{base.parameterize}-#{counter}"
      counter += 1
    end

    slug
  end
end
