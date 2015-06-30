class User < ActiveRecord::Base
  enum role: [:member, :admin]

  has_many :request_books, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :book_states, dependent: :destroy
  has_many :book_favorites, dependent: :destroy
  has_many :books, through: :book_states
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :reviews, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}

  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :validatable

  def follow other_user
    active_relationships.create! followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def reading book
    book_states.create! book_id: book.id, state: Settings.reading
  end

  def reading? book
    book_states.exists? book_id: book.id, state: Settings.reading
  end

  def read? book
    book_states.exists? book_id: book.id, state: Settings.read
  end

  def favourite book
    book_favorites.create! book_id: book.id, favorite: true
  end

  def unfavourite book
    book_favorites.find_by(id: book.id).destroy
  end

  def favourite? book
    book_favorites.exists? book_id: book.id, favorite: true
  end

  def follow_activity? activity
    active_relationships.exists?(id: activity.target_id) && activity.state_target == Settings.follow
  end

  def read_activity? activity
    book_states.exists?(id: activity.target_id) && activity.state_target == Settings.read
  end

  def favorite_activity? activity
    book_favorites.exists?(id: activity.target_id) && activity.state_target == Settings.favorite
  end

  def find_followed activity
    relationship = Relationship.find activity
    user = relationship.followed
  end

  def find_read activity
    book_read = BookState.find activity
    book = book_read.book
  end

  def find_favorite activity
    favorite_book = BookFavorite.find activity
    book = favorite_book.book
  end

  def like other_activity
    likes.create! activity_id: other_activity.id, like: true
  end

  def unlike other_activity
    likes.find_by(activity_id: other_activity.id).destroy
  end

  def liking? other_activity
    likes.exists? activity_id: other_activity.id
  end
end
