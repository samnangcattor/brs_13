class BookState < ActiveRecord::Base
  after_update :activity_read

  belongs_to :user
  belongs_to :book

  private
  def activity_read
    user.activities.create target_id: id, state_target: Settings.read
  end
end
