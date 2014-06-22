module Sluggable
  extend ActiveSupport::Concern

  included do
    class_attribute :slug_column
    after_validation :generate_slug
  end

  def generate_slug
    prefix_slug = self.send(self.slug_column.to_sym).to_slug

    if prefix_slug.length == 0
      prefix_slug = self.id.to_s
    end

    count = 1
    the_slug = prefix_slug
    obj = self.class.find_by(slug: the_slug)
    while obj && obj != self
      the_slug = prefix_slug + '-' + count.to_s
      count += 1
      obj = self.class.find_by(slug: the_slug)
    end

    self.slug = the_slug
  end

  def to_param
    self.slug
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end

end