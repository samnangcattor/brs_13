class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :target_id, presence: true
  validates :state, presence: true, length: {maximum: 50}
end
