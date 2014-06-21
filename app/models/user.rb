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
    self.slug = self.username.to_slug
  end

  def to_param
    self.slug
  end
end