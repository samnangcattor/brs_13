class Comment < ActiveRecord::Base
  after_create :activity_comment

  belongs_to :user
  belongs_to :review

  validates :comment, presence: true, length: {maximum: 500}

  private
  def activity_comment
    user.activities.create target_id: id, state_target: Settings.comment
  end
end
