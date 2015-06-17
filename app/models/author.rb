class Author < ActiveRecord::Base
  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books

  validates :name, presence: true, length: {maximum: 45}
end
