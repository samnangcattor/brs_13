class Category < ActiveRecord::Base
  has_many :book_category, dependent: :destroy
  has_many :books, through: :book_categories

  validates :name, presence: true, length: {maximum: 45}
end
