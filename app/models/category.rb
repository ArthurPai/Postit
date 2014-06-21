class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true

  after_validation :generate_slug

  def generate_slug
    slug_tail = self.name.to_slug

    if slug_tail.length > 0
      self.slug = "#{self.id}-" + slug_tail
    else
      self.slug = "#{self.id}"
    end
  end

  def to_param
    slug
  end
end