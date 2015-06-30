class Relationship < ActiveRecord::Base
  after_create :activity_follow
  after_destroy :activity_unfollow

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  private
  def activity_follow
    follower.activities.create target_id: id, state_target: Settings.follow
  end

  def activity_unfollow
    follower.activities.create target_id: id, state_target: Settings.unfollow
  end
end
