class User < ActiveRecord::Base
  has_many :request_books, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :book_states, dependent: :destroy
  has_many :books, through: :book_states

  validates :name, presence: true, length: {maximum: 50}

  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :validatable
end
