class Book < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :book_states, dependent: :destroy
  has_many :users, through: :book_states
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories

  validates :title, presence: true, length: {maximum: 100}
  validates :publish_date, presence: true
  validates :page, presence: true, numericality: {only_integer: true, greater_than: 0}
end
