class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true

  after_validation :generate_slug

  def generate_slug
    self.slug = self.name.to_slug
  end

  def to_param
    self.slug
  end
end