class Post < ActiveRecord::Base
  include VoteableArthur

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: { minimum: 5, maximum: 120 }
  validates :url, presence: true, length: { maximum: 120 }
  validates :description, presence: true

  after_validation :generate_slug

  def generate_slug
    prefix_slug = self.title.to_slug

    if prefix_slug.length == 0
      prefix_slug = self.id.to_s
    end

    count = 1
    the_slug = prefix_slug
    post = Post.find_by(slug: the_slug)
    while post && post != self
      the_slug = prefix_slug + '-' + count.to_s
      count += 1
      post = Post.find_by(slug: the_slug)
    end

    self.slug = the_slug
  end

  def to_param
    self.slug
  end

end