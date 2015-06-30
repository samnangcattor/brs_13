class Review < ActiveRecord::Base
  after_create :activity_review

  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy

  validates :review, presence: true, length: {maximum: 500}
  validates :rate, presence: true

  private
  def activity_review
    user.activities.create target_id: id, state_target: Settings.review
  end
end
