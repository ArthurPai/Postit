class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 4 }, on: :create
  validates :password, allow_blank: true, length: { minimum: 4 }, on: :update

  after_validation :generate_slug

  def generate_slug
    slug_tail = self.username.to_slug

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