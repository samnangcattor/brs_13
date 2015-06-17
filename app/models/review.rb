class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy

  validates :review, presence: true, length: {maximum: 500}
  validates :rate, presence: true
end
