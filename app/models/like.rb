class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  validates :like, presence: true
end
