class Post < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: { minimum: 5, maximum: 120 }
  validates :url, presence: true, length: { maximum: 120 }
  validates :description, presence: true

  validate :exist_category

  def exist_category
    all_categorie_ids = Category.all.ids
    unless category_ids.all? { |e| all_categorie_ids.include?(e) }
      errors.add(:category_ids, "have some category is not exist")
    end
  end
end