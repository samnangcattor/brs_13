class AcceptBook
  include Sidekiq::Worker

  def perform user_id, request_book_id
    user = User.find user_id
    request_book = RequestBook.find request_book_id
    UserMailer.accepting_book(user, request_book).deliver_now
  end
end
