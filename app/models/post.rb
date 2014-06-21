class Post < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: { minimum: 5, maximum: 120 }
  validates :url, presence: true, length: { maximum: 120 }
  validates :description, presence: true

  after_validation :generate_slug

  def generate_slug
    slug_tail = self.title.to_slug

    if slug_tail.length > 0
      self.slug = "#{self.id}-" + slug_tail
    else
      self.slug = "#{self.id}"
    end
  end

  def to_param
    slug
  end

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

end