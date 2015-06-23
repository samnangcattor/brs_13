class Book < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :book_states, dependent: :destroy
  has_many :users, through: :book_states
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories

  accepts_nested_attributes_for :author_books, allow_destroy: true
  accepts_nested_attributes_for :book_categories, allow_destroy: true

  validates :title, presence: true, length: {maximum: 100}
  validates :publish_date, presence: true
  validates :page, presence: true, numericality: {only_integer: true, greater_than: 0}

end
