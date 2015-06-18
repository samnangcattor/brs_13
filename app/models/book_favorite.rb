class BookFavorite < ActiveRecord::Base
  after_create :activity_favorite

  belongs_to :user
  belongs_to :book

  private
  def activity_favorite
    user.activities.create target_id: id, state_target: Settings.favorite
  end
end
